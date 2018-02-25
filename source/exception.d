class SyntaxErrorException : Exception{
    this(string message){
        super(message);
    }
}

class RuntimeErrorException : Exception{
    this(string message){
        super(message);
    }
}