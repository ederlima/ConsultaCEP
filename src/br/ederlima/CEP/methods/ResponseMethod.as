package br.ederlima.CEP.methods
{
	
	/**
	 * <strong>ResponseMethod</strong><br />
	 * A Classe ResponseMethod é responsável por selecionar entre os métodos XML_METHOD ou TEXT_METHOD permitindo
	 * ao usuário selecionar o método de conexão que mais se encaixa ao seu uso, por padrão o método selecionado
	 * é o XML_METHOD.
	 * @author Eder Lima
	 */
	public class ResponseMethod extends Object
	{
		/**
		 * Utilizar resposta em XML
		 */
		public static const XML_METHOD:String = "xml";
		/**
		 * Utilizar resposta em Texto
		 */
		public static const TEXT_METHOD:String = "text";
		
		public function ResponseMethod() ;
		
	}
	
}