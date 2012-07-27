package br.ederlima.CEP.events 
{
	import br.ederlima.CEP.data.DataItem;
	import flash.events.Event;
	
	/**
	 * <strong>ConsultaCepEvent</strong><br />
	 * A Classe ConsultaCepEvent é responsável por receber os eventos dos conectores (TextConnector e XmlConnector) e os
	 * dados constados na DataItem em forma de mensagem e Array, permitindo trabalhar os dados.
	 * @author Eder Lima
	 */
	public class ConsultaCepEvent extends Event
	{
		public var data:DataItem = new DataItem();
		/**
		 * Evento disparado quando a resposta conter resultados
		 */
		public static const RESPONSE:String = "response";
		/**
		 * Evento disparado quando a resposta for nula ou conter erros
		 */
		public static const ERROR:String = "error";
		/**
		 * 
		 * @param	type Tipo do Evento
		 * @param	dataitem Objeto DataItem contendo a mensagem e o array com as respostas
		 * @param	bubbles Bubbles 
		 * @param	cancelable Cancelable
		 */
		public function ConsultaCepEvent(type:String, dataitem:DataItem = null, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			data = dataitem;
			super(type, bubbles, cancelable);
		}
		/**
		 * Clona o Evento
		 * @return
		 */
		public override function clone():Event
		{
			return new ConsultaCepEvent(this.type, data, this.bubbles, this.cancelable);
		}
		/**
		 * Informa o Tipo do Evento e os dados
		 * @return
		 */
		public override function toString():String
        {
            return formatToString("ConsultaCepEvent", "data", "type", "bubbles", "cancelable");
        }
		
	}
	
}