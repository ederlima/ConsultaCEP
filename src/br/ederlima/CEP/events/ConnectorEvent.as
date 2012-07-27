package br.ederlima.CEP.events 
{
	import flash.events.Event;
	import br.ederlima.CEP.data.DataItem;
	/**
	 * <strong>ConnectorEvent</strong><br />
	 * A Classe ConnectorEvent é uma Classe que extende a Event, para trabalhar os dados e as respostas 
	 * das consultas tratando os erros e transportando os dados.
	 * @author Eder Lima
	 */
	public class ConnectorEvent extends Event
	{
		/**
		 * Objeto DataItem contendo o a mensagem e o array com os resultados
		 */
		public var data:DataItem = new DataItem();
		/**
		 * Resposta do Servidor
		 */
		public static const RESPONSE:String = "response";
		/**
		 * Resposta de erro
		 */
		public static const ERROR:String = "error";
		/**
		 * Resposta de erro para falta de chave caso o método escolhido seja AuthMethod.SIGNED
		 */
		public static const KEY_ERROR:String = "keyError";
		/**
		 * TextMethodEvent
		 * @param	type Tipo do Evento
		 * @param	dataitem Objeto DataItem contendo a mensagem e o array com as respostas
		 * @param	bubbles Bubbles 
		 * @param	cancelable Cancelable
		 */
		public function ConnectorEvent(type:String, dataitem:DataItem = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			data = dataitem;
		}
		/**
		 * Clona o Evento
		 * @return
		 */
		public override function clone():Event
		{
			return new ConnectorEvent(this.type, data, this.bubbles, this.cancelable);
		}
		/**
		 * Informa o Tipo do Evento e os dados
		 * @return
		 */
		public override function toString():String
        {
            return formatToString("ConnectorEvent", "data", "type", "bubbles", "cancelable");
        }
		
	}
	
}