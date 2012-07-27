package br.ederlima.CEP.data 
{
	
	/**
	 * <strong>DataItem</strong><br />
	 * A Classe DataItem é responsável por receber das Classes XmlConnector e TextConnector os dados e as mensagens
	 * das requisições feitas ao Webservice e transportar esses dados até a Classe ConsultaCep
	 * @author Eder Lima
	 */
	public class DataItem extends Object
	{
		private var _response:Array = [];
		private var _msg:String = "";
		/**
		 * DataItem
		 * Objeto que guarda as mensagem de erro e os dados de cada consulta
		 */
		public function DataItem() 
		{
			
		}
		/**
		 * Array com os obetjos
		 */
		public function get response():Array
		{
			return _response;
		}
		public function set response(value:Array):void
		{
			_response = value;
		}
		/**
		 * String com a mensagem de erro ou sucesso
		 */
		public function get message():String
		{
			return _msg;
		}
		public function set message(value:String):void
		{
			_msg = value;
		}
		
	}
	
}