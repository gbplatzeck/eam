package br.com.eam.exception;

public class KnowledgeNotImplementedException extends RuntimeException {

	private static final long serialVersionUID = 5293188561196176656L;

	public KnowledgeNotImplementedException(){
		super();
	}
	
	public KnowledgeNotImplementedException(String name){
		super(name);
	}
}
