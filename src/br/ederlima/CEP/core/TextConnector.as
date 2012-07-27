package br.ederlima.CEP.core
{
	import br.ederlima.CEP.data.LocalItem;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import br.ederlima.CEP.events.ConnectorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoaderDataFormat;
	import br.ederlima.CEP.data.DataItem;
	import br.ederlima.CEP.methods.AuthMethod;
	
	/**
	 * <strong>TextConnector</strong><br />
	 * A Classe TextConnector é responsável por receber os dados do Webservice utilizando a interface String
	 * @author Eder Lima
	 */
	public class TextConnector
	{
		private var _method:String = AuthMethod.UNSIGNED;
		private var _key:String = "";
		private var _baseurl:String = "http://www.buscarcep.com.br/";
		private var _requestString:URLRequest;
		private var _sufixResponseMethod:String = "";
		private var _connector:URLLoader = new URLLoader();
		private var _serviceurl:URLRequest = new URLRequest();
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _responseString:String = "";
		private var _vars:URLVariables;
		private var _results:Array = new Array();
		private var _dataArray:Array = new Array();
		private var _errorString:String = "";
		private var _dataItem:DataItem = new DataItem();
		/**
		 * Construtor da Classe
		 */
		public function TextConnector() 
		{
			configureEnviroment();
		}
		/**
		 * Enviar requisição
		 * @param	request String contendo os parâmetros para consulta, ex: "cep=79020001" ou "logradouro=Afonso Pena&cidade=Campo Grande"
		 */
		public function sendRequest(request:String):void
		{
			createRequest(request);
		}
		/**
		 * Adiciona um evento
		 * @param	type Evento do tipo ConnectorEvent
		 * @param	listener Função disparada com o Evento
		 */
		public function addEventListener(type:String, listener:Function):void
		{
			_dispatcher.addEventListener(type, listener,false,0,false)
		}
		/**
		 * Remove um evento
		 * @param	type Evento do tipo ConnectorEvent
		 * @param	listener Função para remover o evento
		 */
		public function removeEventListener(type:String, listener:Function):void
		{
			_dispatcher.removeEventListener(type, listener,false)
		}
		private function configureEnviroment():void
		{
			_connector.dataFormat = URLLoaderDataFormat.TEXT;
			_connector.addEventListener(Event.COMPLETE, cepRequestHandler);
			_connector.addEventListener(IOErrorEvent.IO_ERROR, requestIOError);
			_connector.addEventListener(HTTPStatusEvent.HTTP_STATUS, requestStatus);
		}
		private function createRequest(requestUrl:String = ""):void
		{
			if (_method == AuthMethod.SIGNED)
			{
				if (_key == "")
				{
					_dataItem.message = "Você precisa inserir uma chave para utilizar o Método AuthMethod.SIGNED";
					_dispatcher.dispatchEvent(new ConnectorEvent(ConnectorEvent.KEY_ERROR, _dataItem));
				}
				else
				{
					_sufixResponseMethod = "&formato=string&chave=" + _key;
					_requestString = new URLRequest(_baseurl + "?" + requestUrl + _sufixResponseMethod);
					_connector.load(_requestString);
				}
			}
			else
			{
				_sufixResponseMethod = "&formato=string";
				_requestString = new URLRequest(_baseurl + "?" + requestUrl + _sufixResponseMethod);
				_connector.load(_requestString);
			}	
		}
		private function cepRequestHandler(event:Event):void
		{
			_results = [];
			_dataArray = [];
			if (String(event.target.data).charAt(1) == "c")
			{
				createResults(event.target.data);
			}
			else
			{
				_responseString = String(event.target.data).slice(1);
				_vars = new URLVariables(_responseString);
				dispatchErrors(_vars.resultado);
			}
		}
		private function createResults(value:String = ""):void
		{
			_responseString = value;
			_results = _responseString.split("&cep=");
			_results.shift();
			for each(var _item:String in _results)
			{
				_vars = new URLVariables(String("cep=" + _item));
				var _localitem:LocalItem = new LocalItem();
				_localitem.cep = _vars.cep;
				_localitem.uf = _vars.uf;
				_localitem.cidade = _vars.cidade;
				_localitem.bairro = _vars.bairro;
				_localitem.tipologradouro = _vars.tipo_logradouro;
				_localitem.logradouro = _vars.logradouro;
				_localitem.resultado = _vars.resultado;
				_localitem.mensagem = _vars.resultado_txt;
				_localitem.apicalls = _vars.limite_buscas;
				_localitem.ufibge = _vars.ibge_uf;
				_localitem.municipioibge = _vars.ibge_municipio;
				_localitem.verificadoribge = _vars.ibge_municipio_verificador;
				_dataArray[_dataArray.length] = _localitem;
			}
			dispatchErrors(_vars.resultado);
		}
		private function dispatchErrors(value:Number):void
		{
			switch(value)
			{
				case 1 :
				_errorString = "CEP Encontrado.";
				dispatchResponse();
				break;
				case -1 :
				_errorString = "CEP ou Logradouro não encontrados.";
				dispatchError();
				break;
				case -2 :
				_errorString = "Formato de CEP inválido.";
				dispatchError();
				break;
				case -3 :
				_errorString = "Limite de buscas por minuto excedido.";
				dispatchError();
				break;
				case -4 :
				_errorString = "IP Banido.";
				dispatchError();
				break;
				case -5 :
				_errorString = "Chave banida.";
				dispatchError();
				break;
				case -6 :
				_errorString = "Das 00h às 06h as consultas são limitadas a 10 por minuto.";
				dispatchError();
				break;
				default:
				sendCriticalError();
			}
		}
		private function dispatchResponse():void
		{
			_dataItem.message = "CEP encontrado.";
			_dataItem.response = _dataArray;
			_dispatcher.dispatchEvent(new ConnectorEvent(ConnectorEvent.RESPONSE, _dataItem));
		}
		private function requestIOError(event:IOErrorEvent):void
		{
			_errorString = "URL Não encontrada";
			_dataItem.message = _errorString;
			_dispatcher.dispatchEvent(new ConnectorEvent(ConnectorEvent.ERROR, _dataItem));
		}
		private function requestStatus(event:HTTPStatusEvent):void
		{
			trace("HTTP Status: " + event.status);
			trace("ResponseMethod: TEXT");
		}
		private function sendCriticalError():void
		{
			_errorString = "Erro inesperado, tente novamente";
			_dataItem.message = _errorString;
			_dispatcher.dispatchEvent(new ConnectorEvent(ConnectorEvent.ERROR, _dataItem));
		}
		private function dispatchError():void
		{
			_dataItem.message = _errorString;
			_dispatcher.dispatchEvent(new ConnectorEvent(ConnectorEvent.ERROR, _dataItem));
		}
		/**
		 * Url do serviço. Padrão (http://www.buscarcep.com.br/)
		 */
		public function get baseURL():String
		{
			return _baseurl;
		}
		public function set baseURL(value:String):void
		{
			_baseurl = value;
		}
		/**
		 * Sua Key única, fornecida quando você se cadastra no Serviço
		 */
		public function get key():String
		{
			return _key;
		}
		public function set key(value:String):void
		{
			_key = value;
		}
		/**
		 * Método de autenticação Use AuthMethod.SIGNED para utilizar a Key fornecida pelo Serviço
		 */
		public function get authMethod():String
		{
			return _method;
		}
		public function set authMethod(value:String):void
		{
			_method = value;
		}
	}
	
}