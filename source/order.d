import engine;
import std.stdio, std.conv;

interface Order{
    public Engine opCall(Engine engine);
}

class Plus : Order{
    public Engine opCall(Engine engine) {
        engine.memory[engine.ptr] += 1;
        return engine;
    }
}

class Minus : Order{
    public Engine opCall(Engine engine){
        engine.memory[engine.ptr] -= 1;
        return engine;
    }
}

class Right : Order{
    public Engine opCall(Engine engine){
        engine.ptr += 1;
        return engine;
    }
}

class Left : Order{
    public Engine opCall(Engine engine){
        engine.ptr -= 1;
        return engine;
    }
}

class PutChar : Order{
    public Engine opCall(Engine engine){
        char c = engine.memory[engine.ptr];
        putchar(c);
        return engine;
    }
}

class GetChar : Order{
    public Engine opCall(Engine engine){
        ubyte c = getc(stdin.getFP).to!ubyte;
        engine.memory[engine.ptr] = c;
        return engine;
    }
}

class If0 : Order{

    private uint jumpPtr;
    public void setJumpDest(uint jumpDest){
        jumpPtr = jumpDest;
    }

    public Engine opCall(Engine engine){
        if(engine.memory[engine.ptr] == 0){
            engine.counter = jumpPtr;
        }
        return engine;
    }
}

class IfNot0 : Order{

    private uint jumpPtr;
    public void setJumpDest(uint jumpDest){
        jumpPtr = jumpDest;
    }

    public Engine opCall(Engine engine){
        if(engine.memory[engine.ptr] != 0){
            engine.counter = jumpPtr;
        }
        return engine;
    }
}