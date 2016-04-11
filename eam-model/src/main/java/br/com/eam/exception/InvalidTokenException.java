package br.com.eam.exception;

public class InvalidTokenException extends Exception {

	private static final long serialVersionUID = 8534827076987490709L;

	public InvalidTokenException(){
		super();
	}
	
	public InvalidTokenException(String message){
		super(message);
	}
}
