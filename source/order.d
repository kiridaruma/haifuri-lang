import engine;
import std.stdio, std.conv;

interface Order{
    public immutable Engine opCall(Engine engine);
}

class Plus : Order{
    public immutable Engine opCall(Engine engine) {
        engine.memory[engine.ptr] += 1;
        return engine;
    }
}

class Minus : Order{
    public immutable Engine opCall(Engine engine) {
        engine.memory[engine.ptr] -= 1;
        return engine;
    }
}

class Right : Order{
    public immutable Engine opCall(Engine engine) {
        // メモリサイズをチェックして、限界なら2倍に伸ばす
        if(engine.memory.length - 1 == engine.ptr) engine.memory.length *= 2;
        engine.ptr += 1;
        return engine;
    }
}

class Left : Order{
    public immutable Engine opCall(Engine engine) {
        // ポインタ位置が一番左なら、これ以上左に進めないのでエラー
        if(engine.memory.length == 0) throw new Exception("これ以上とりかじは取れないよ(泣)");
        engine.ptr -= 1;
        return engine;
    }
}

class PutChar : Order{
    public immutable Engine opCall(Engine engine) {
        char c = engine.memory[engine.ptr];
        putchar(c);
        return engine;
    }
}

class GetChar : Order{
    public immutable Engine opCall(Engine engine) {
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

    public immutable Engine opCall(Engine engine) {
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

    public immutable Engine opCall(Engine engine) {
        if(engine.memory[engine.ptr] != 0){
            engine.counter = jumpPtr;
        }
        return engine;
    }
}