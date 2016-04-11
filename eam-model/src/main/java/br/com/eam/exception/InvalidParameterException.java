package br.com.eam.exception;

public class InvalidParameterException extends Exception {

    private static final long serialVersionUID = 2244811379758738585L;

    private Object[] args;

    public InvalidParameterException() {
        super();
    }

    public InvalidParameterException(String message) {
        super(message);
    }

    public InvalidParameterException(String message, Object[] args) {
        super(message);
        setArgs(args);
    }

    public InvalidParameterException(String message, Throwable cause) {
        super(message, cause);
    }

    public Object[] getArgs() {
        return args;
    }

    public void setArgs(Object[] args) {
        this.args = args;
    }
}
