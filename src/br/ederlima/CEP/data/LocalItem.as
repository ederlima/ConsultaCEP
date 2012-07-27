package br.ederlima.CEP.data
{
	
	/**
	 * <strong>LocalItem</strong><br />
	 * A Classe LocalItem é uma Classe de Objeto que guarda as informações de cada resposta a uma consulta 
	 * em propriedades com os mesmos nomes dos dados
	 * @author Eder Lima
	 */
	public class LocalItem extends Object
	{
		//variáveis privadas
		private var _cep:String;
		private var _uf:String;
		private var _cidade:String;
		private var _bairro:String;
		private var _logradouro:String;
		private var _tipologradouro:String;
		private var _resultado:Number;
		private var _mensagem:String;
		private var _apicalls:uint;
		private var _ufibge:uint;
		private var _municipioibge:uint;
		private var _verificadoribge:uint;
		private var _id:int = 0;
		/**
		 * Construtor da Classe
		 * Instancia um novo Item da Classe LocalItem
		 */
		public function LocalItem() 
		{
			
		}
		/**
		 * CEP
		 */
		public function get cep():String
		{
			return _cep;
		}
		public function set cep(value:String):void
		{
			_cep = value;
		}
		/**
		 * Estado
		 */
		public function get uf():String
		{
			return _uf;
		}
		public function set uf(value:String):void
		{
			_uf = value;
		}
		/**
		 * Cidade
		 */
		public function get cidade():String
		{
			return _cidade;
		}
		public function set cidade(value:String):void
		{
			_cidade = value;
		}
		/**
		 * Bairro
		 */
		public function get bairro():String
		{
			return _bairro
		}
		public function set bairro(value:String):void
		{
			_bairro = value;
		}
		/**
		 * Tipo de Logradouro
		 */
		public function get tipologradouro():String
		{
			return _tipologradouro;
		}
		public function set tipologradouro(value:String):void
		{
			_tipologradouro = value;
		}
		/**
		 * Logradouro
		 */
		public function get logradouro():String
		{
			return _logradouro;
		}
		public function set logradouro(value:String):void
		{
			_logradouro = value;
		}
		/**
		 * Código do Resultado
		 */
		public function get resultado():Number
		{
			return _resultado;
		}
		public function set resultado(value:Number):void
		{
			_resultado = value;
		}
		/**
		 * Mensagem
		 */
		public function get mensagem():String
		{
			return _mensagem;
		}
		public function set mensagem(value:String):void
		{
			_mensagem = value;
		}
		/**
		 * Api Calls restantes
		 */
		public function get apicalls():uint
		{
			return _apicalls;
		}
		public function set apicalls(value:uint):void
		{
			_apicalls = value;
		}
		/**
		 * Código do Estado no IBGE
		 */
		public function get ufibge():uint
		{
			return _ufibge;
		}
		public function set ufibge(value:uint):void
		{
			_ufibge = value;
		}
		/**
		 * Código do Município no IBGE
		 */
		public function get municipioibge():uint
		{
			return _municipioibge;
		}
		public function set municipioibge(value:uint):void
		{
			_municipioibge = value;
		}
		/**
		 * Código verificador do Município no IBGE
		 */
		public function get verificadoribge():uint
		{
			return _verificadoribge;
		}
		public function set verificadoribge(value:uint):void
		{
			_verificadoribge = value;
		}
		/**
		 * Código do Cliente assinante do Serviço
		 */
		public function get id():int
		{
			return _id;
		}
		public function set id(value:int):void
		{
			_id = value;
		}
	}
	
}