package 
{
	import br.ederlima.CEP.ConsultaCep;
	import br.ederlima.CEP.events.ConsultaCepEvent;
	import br.ederlima.CEP.data.LocalItem;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * FormExample - Consula Cep API
	 * @author Eder Lima
	 * @copy FlashPedia
	 */
	public class FormExample extends Sprite
	{
		//Criando uma referência para o formulário que está na biblioteca
		private var form:Form = new Form();
		//Criando uma referência para o inputtext do cep
		private var mycep:TextField = form.cep;
		//criando um objeto ConsultaCep
		private var consulta:ConsultaCep = new ConsultaCep();
		
		public function FormExample()
		{
			//configurando o ambiente ao iniciar
			addEventListener(Event.ADDED_TO_STAGE, configure);
		}
		//Função que configura o ambiente
		private function configure(event = null):void
		{
			//posicionando o formulário
			form.x = form.y = 0;
			//adicionando o formulário ao palco
			addChild(form);
			//desconsiderando os filhos da mensagem (apenas para evitar que o cursor mude)
			form.msg.mouseChildren = false;
			//escondendo a mensagem
			form.msg.visible = false;
			//criando um ouvinte para a resposta da consulta
			consulta.addEventListener(ConsultaCepEvent.RESPONSE, responseHandler);
			//criando um ouvinte para a resposta de erro
			consulta.addEventListener(ConsultaCepEvent.ERROR, errorHandler);
			//adicionando um evento ao digitar o cep
			mycep.addEventListener(Event.CHANGE, inputHandler);
			//limitando a quantidade de caracteres do cep a 8 caraceteres "79103600", sem máscara 
			mycep.maxChars = 8;
		}
		//Função que responde a interação com o campo cep
		private function inputHandler(event:Event):void
		{
			//Limpar os campos (caso não seja a primeira busca)
			clearFields();
			form.msg.visible = false;
			//caso o campo contenha 8 caracteres
			if (mycep.length == 8)
			{
				//Mostrar mensagem informando que a busca está em andamento
				form.msg.msg.text = "Buscando endereço...";
				form.msg.visible = true;
				//Relizar a Busca utilizando o cep digitado
				consulta.buscarLocal(mycep.text);
			}
			
		}
		//Função de resposta positiva da consulta
		private function responseHandler(event:ConsultaCepEvent):void
		{
			//cria-se um objeto LocalItem (que comporta os dados)
			//utilizando a posição 0[1] do objeto data.response (objeto "data" e array "response" com os dados da consulta)
			var localItem:LocalItem = event.data.response[0];
			//informando os dados em cada campo utlizando as propriedades de cada objeto LocalItem
			form.logradouro.text = localItem.logradouro;
			form.bairro.text = localItem.bairro;
			form.cidade.text = localItem.cidade;
			form.estado.text = localItem.uf;
			//Informando o status enviado pelo serviço sobre a consulta (data.message)
			form.msg.msg.text = event.data.message;
			form.msg.visible = true;
		}
		//Função que responde ao erro da consulta
		private function errorHandler(event:ConsultaCepEvent):void
		{
			//limpa os campos
			clearFields();
			//exibe a mensagem de erro carregada no objeto (data.message)
			form.msg.msg.text = event.data.message;
			form.msg.visible = true;
		}
		//Função que limpa os campos
		private function clearFields():void
		{
			form.logradouro.text = "";
			form.bairro.text = "";
			form.cidade.text = "";
			form.estado.text = "";
			form.msg.msg.text = "";
		}
	}
	
}