package br.ederlima.CEP 
{
	import br.ederlima.CEP.events.ConsultaCepEvent;
	import br.ederlima.CEP.methods.ResponseMethod;
	import br.ederlima.CEP.methods.AuthMethod;
	import br.ederlima.CEP.core.XmlConnector;
	import br.ederlima.CEP.core.TextConnector;
	import br.ederlima.CEP.events.ConnectorEvent;
	import br.ederlima.CEP.data.DataItem;
	import br.ederlima.CEP.data.LocalItem;
	import flash.events.EventDispatcher;
	
	/**
		<strong>Consulta CEP </strong><br />
		A Classe <strong>ConsultaCep</strong> permite ao usuário fazer consultas para obter CEP e     Endereço de Logradouros de todo o Brasil utilizando o Webservice <a href="http://www.buscarcep.com.br" target="_blank" title="Buscar CEP">http://www.buscarcep.com.br</a>. <br />
		Esta Classe é distribuída gratuitamente, como colaboração com a comunidade e com o próprio serviço, tal como     está, sem garantias contra erros ou mal funcionamento. <br />
		<br /><strong>Para fazer download, vá até <a href="http://www.ederlima.com.br/arquivos/flash/ConsultaCep/ConsultaCep.rar" target="_blank" title="Fazer download da API">http://www.ederlima.com.br/arquivos/flash/ConsultaCep/ConsultaCep.rar</a></strong>
		<br /><br />
		<h3>Como utilizar:</h3>
		<ul>
		  <li> <strong>Informando o CEP e retornando a informação completa</strong><br />
			<br />
			<blockquote><code>import br.ederlima.CEP.ConsultaCep;<br />
			import br.ederlima.CEP.events.ConsultaCepEvent;<br />
			import br.ederlima.CEP.data.LocalItem;<br />
			var consulta:ConsultaCep = new ConsultaCep();<br />
			consulta.addEventListener(ConsultaCepEvent.RESPONSE, responseHandler);<br />
			consulta.addEventListener(ConsultaCepEvent.ERROR, errorHandler);<br />
			consulta.buscarLocal(&quot;79103600&quot;);<br />
			function responseHandler(event:ConsultaCepEvent):void<br />
			{<br />
			for each(var item:LocalItem in event.data.response)<br />
			{<br />
			trace(&quot;CEP: &quot; + item.cep + &quot; Logradouro: &quot; + item.logradouro + &quot; Bairro: &quot; + item.bairro + &quot; Cidade: &quot; + item.cidade);<br />
			}<br />
			} <br />
			function errorHandler(event:ConsultaCepEvent):void<br />
			{<br />
			trace(event.data.message); <br />
			}</code></blockquote><br /><br />
		  </li>
		  <li><strong>Informando o Endereço e retornando a informação completa</strong><br />
			<br />
			<blockquote><code>import br.ederlima.CEP.ConsultaCep;<br />
			import br.ederlima.CEP.events.ConsultaCepEvent;<br />
			import br.ederlima.CEP.data.LocalItem; <br />
			var consulta:ConsultaCep = new ConsultaCep();<br />
			consulta.addEventListener(ConsultaCepEvent.RESPONSE, responseHandler);<br />
			consulta.addEventListener(ConsultaCepEvent.ERROR, errorHandler);<br />
			consulta.buscarCep(&quot;Afrânio Fialho&quot;, &quot;Campo Grande&quot;);<br />
			function responseHandler(event:ConsultaCepEvent):void<br />
			{<br />
			for each(var item:LocalItem in event.data.response)<br />
			{<br />
			trace(&quot;CEP: &quot; + item.cep + &quot; Logradouro: &quot; + item.logradouro + &quot; Bairro: &quot; + item.bairro + &quot; Cidade: &quot; + item.cidade);<br />
			}<br />
			} <br />
			function errorHandler(event:ConsultaCepEvent):void<br />
			{<br />
			trace(event.data.message); <br />
			}</code></blockquote></li>
		</ul>
		<h3>Dados</h3>
		<p>São dois métodos diferentes de consulta, porém o resultado é sempre o mesmo, trazendo a informação completa do Endereço ou Cep pesquisado, os dados são retornados em um objeto LocalItem, com as seguintes propriedades:</p>
		<ul>
		  <li><strong>cep</strong>: Cep do Local</li>
		  <li> <strong>uf</strong>: Estado</li>
		  <li><strong>cidade</strong>: Cidade</li>
		  <li> <strong>bairro</strong>: Bairro</li>
		  <li><strong>tipologradouro</strong>: Tipo de Logradouro (ex: Rua, Avenida)</li>
		  <li><strong>logradouro</strong>: Nome do Logradouro</li>
		  <li> <strong>resultado</strong>: Valor do resultado</li>
		  <li> <strong>mensagem</strong>: Mensagem do sistema para cada item</li>
		  <li> <strong>apicalls</strong>: Chamadas de API restantes</li>
		  <li> <strong>ufibge</strong>: Código do Estado no IBGE</li>
		  <li> <strong>municipioibge</strong>: Código do Município no IBGE</li>
		  <li> <strong>verificadoribge</strong>: Código verificador do IBGE</li>
		</ul>
		<h3>Fazendo Requisições Autenticadas</h3>
		<p>O Webservice do <strong>BuscarCep.com.br</strong> permite por padrão que um mesmo IP faça no máximo 5 requisições por minuto para os servidores do serviço, isso é uma forma de garantir o bom funcionamento.<br />
		</p>
		<p>Para fazer mais solicitações por minuto é necessário cadastrar-se no <a href="http://www.buscarcep.com.br" title="Cadastre-se" target="_blank">BuscarCep.com.br</a> e conseguir sua chave única. A chave única é um código criptografado que identifica seu cadastro e permite a você fazer até 20 requisções por minuto, por IP. Uma vez cadastrado é possível utilizar a api com essa forma de autenticação.</p>
		<h3>Utilizando a API Key para fazer consultas</h3>
		<p>A Classe é preparada para isso e usar autenticação é muito simples, você só precisa selecionar valores para duas propriedades da Classe <strong>ConsultaCep</strong>, são elas:</p>
		<ul>
		  <li><strong>authMethod</strong>: Método de autorização, você escolhe entre: &quot;Assinado&quot; <strong>AuthMethod.SIGNED</strong> ou &quot;Não-assinado&quot; <strong>AuthMethod.UNSIGNED</strong></li>
		  <li><strong>key</strong>: A sua chave única, recebida no seu cadastro, em formato <strong>String</strong>, ex: &quot;983u48d8/x7a7f4dsd/23.&quot;</li>
		</ul>
		<p><strong>Dessa forma, para consultar utilizando a sua API Key:</strong></p>
		<blockquote><p><code>
		import br.ederlima.CEP.methods.AuthMethod; <br />
		consulta.authMethod = AuthMethod.SIGNED;<br />
		  consulta.key = &quot;suaapkeycadastradaeunica&quot;;</code>
		</p></blockquote>
		<h3>Métodos de Resposta</h3>
		<p>Também é possível alterar o método de resposta da Classe ConsultaCep, uma vez que o Webservice oferece duas formas de se conectar e trocar dados:</p>
		<ul>
		  <li>XML</li>
		  <li>String (Tratada na Classe como Texto)</li>
		</ul>
		<p>Para alterar o método de resposta basta configurar a propriedade <strong>responseMethod</strong> do seu objecto ConsultaCep, dessa forma:</p>
		<blockquote><p><code>
		import br.ederlima.CEP.methods.ResponseMethod;<br />
		consulta.responseMethod = ResponseMethod.TEXT_METHOD;</code> //para Método String</p></blockquote>
		<p>ou</p>
		<blockquote><p><code>consulta.responseMethod = ResponseMethod.XML_METHOD;</code> //para Método XML</p></blockquote>
		<p>A Classe é pré-configurada para rodar sem autenticação e através do método XML, porém você pode configurar o funcionamento dela da forma que precisar.</p>
		<h3>Dados do Autor</h3>
		<p>Eder Lima - Webdesigner e Flash Developer<br />
		  http://www.ederlima.com.br</p>
	 * @author Eder Lima
	 * @author url -> http://www.ederlima.com.br
	 */
	public class ConsultaCep
	{
		private var _serviceURL:String = "http://www.buscarcep.com.br/";
		private var _responseMethod:String = ResponseMethod.XML_METHOD;
		private var _authMethod:String = AuthMethod.UNSIGNED;
		private var _xmlConnnector:XmlConnector = new XmlConnector();
		private var _textConnector:TextConnector = new TextConnector();
		private var _queryString:String = "";
		private var _key:String = "";
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var data:DataItem = new DataItem();
		
		/**
		 * Construtor da Classe ConsultaCep
		 */	
		public function ConsultaCep() 
		{
			_xmlConnnector.addEventListener(ConnectorEvent.RESPONSE, responseHandler);
			_xmlConnnector.addEventListener(ConnectorEvent.ERROR, responseError);
			_xmlConnnector.addEventListener(ConnectorEvent.KEY_ERROR, keyError);
			_textConnector.addEventListener(ConnectorEvent.RESPONSE, responseHandler);
			_textConnector.addEventListener(ConnectorEvent.ERROR, responseError);
			_textConnector.addEventListener(ConnectorEvent.KEY_ERROR, keyError);			
		}
		/**
		 * Encontra o CEP pesquisando por nomes de Rua, Cidade e Bairro
		 * @param	logradouro	Rua
		 * @param	cidade	Cidade
		 * @param	bairro	Bairro
		 */
		public function buscarCep(Logradouro:String, Cidade:String, Bairro:String = ""):void
		{
			_xmlConnnector.baseURL = _serviceURL;
			_textConnector.baseURL = _serviceURL;
			_queryString = "logradouro=" + Logradouro + "&cidade=" + Cidade + "&bairro=" + Bairro;
			if (_responseMethod == ResponseMethod.XML_METHOD)
			{
				_xmlConnnector.sendRequest(_queryString);
			}
			else
			{
				_textConnector.sendRequest(_queryString);
			}
		}
		/**
		 * Encontra o endereço pesquisando por CEP
		 * @param	Cep CEP
		 */
		public function buscarLocal(CEP:String):void
		{
			_xmlConnnector.baseURL = _serviceURL;
			_textConnector.baseURL = _serviceURL;
			_queryString = "cep=" + CEP;
			if (_responseMethod == ResponseMethod.XML_METHOD)
			{
				_xmlConnnector.sendRequest(_queryString);
			}
			else
			{
				_textConnector.sendRequest(_queryString);
			}
		}
		/**
		 * Adiciona um evento
		 * @param	type Evento do tipo ConsultaCepEvent
		 * @param	listener Função disparada com o Evento
		 */
		public function addEventListener(type:String, listener:Function):void
		{
			_dispatcher.addEventListener(type, listener,false,0,false)
		}
		/**
		 * Remove um evento
		 * @param	type Evento do tipo ConsultaCepEvent
		 * @param	listener Função para remover o evento
		 */
		public function removeEventListener(type:String, listener:Function):void
		{
			_dispatcher.removeEventListener(type, listener,false)
		}
		
		private function responseHandler(event:ConnectorEvent):void
		{
			data = event.data;
			_dispatcher.dispatchEvent(new ConsultaCepEvent(ConsultaCepEvent.RESPONSE, data));
			
		}
		private function keyError(event:ConnectorEvent):void
		{
			data = event.data;
			_dispatcher.dispatchEvent(new ConsultaCepEvent(ConsultaCepEvent.ERROR, data));
			
		}
		private function responseError(event:ConnectorEvent):void
		{
			data = event.data;
			_dispatcher.dispatchEvent(new ConsultaCepEvent(ConsultaCepEvent.ERROR, data));
			
		}
		/**
		 * Método de autorização
		 * @see br.ederlima.CEP.methods.AuthMethod
		 */
		public function get authMethod():String
		{
			return _authMethod;
		}
		 public function set authMethod(value:String):void
		{
			_authMethod = value;
			_xmlConnnector.authMethod = _authMethod;
			_textConnector.authMethod = _authMethod;
		}
		/**
		 * Chave para utilização do Serviço
		 */
		public function get key():String
		{
			return _key;
		}
		public function set key(value:String):void
		{
			_key = value;
			_xmlConnnector.key = _key;
			_textConnector.key = _key;
		}
		/**
		 * Método de resposta. Padrão: ResponseMethod.XML_METHOD
		 * @see br.ederlima.CEP.methods.ResponseMethod
		 * @see br.ederlima.CEP.core.XmlConnector
		 * @see br.ederlima.CEP.core.TextConnector
		 */
		public function get responseMethod():String
		{
			return _responseMethod;
		}
		 public function set responseMethod(value:String):void
		{
			_responseMethod = value;
		}
		/**
		 * URL do serviço, padrão "http://www.buscarcep.com.br"
		 */
		public function get serviceURL():String
		{
			return _serviceURL;
		}
		public function set serviceURL(value:String):void
		{
			_serviceURL = value;
		}
		
	}
	
}