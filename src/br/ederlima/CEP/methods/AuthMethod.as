package br.ederlima.CEP.methods
{
	/**
	 * <strong>AuthMethod</strong><br />
	 * A Classe AuthMethod é responsável por selecionar entre os métodos SIGNED ou UNSIGNED, permitindo
	 * ao usuário escolher entre usar ou não uma API Key fornecida pelo serviço, por padrão o método de autenticação
	 * selecionado é o AuthMethod.UNSIGNED.
	 * @author Eder Lima
	 */
	public class AuthMethod extends Object
	{
		/**
		 * Utiliza as consultas assinadas
		 */
		public static const SIGNED:String = "signed";
		/**
		 * Utiliza as consultas não assinadas
		 */
		public static const UNSIGNED:String = "unsigned";
		
		public function AuthMethod() ;
		
	}
	
}