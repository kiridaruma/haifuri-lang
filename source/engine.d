import order;
import parser;
import std.string;
import std.regex;
import std.algorithm : filter;
import std.array : array;

class Engine{
    public uint ptr = 0;
    public ubyte[] memory;
    public uint counter = 0;
    public Order[] orders;

    this(string source){
        this.orders = (new Parser(source)).parse();
        this.memory.length = 16; // 初期メモリは16バイトで、そこから倍に増えていく
    }

    public void run(Engine engine = Engine.init){
        if(Engine.init is engine) engine = this;
        if(engine.counter == engine.orders.length) return;
        engine = orders[counter](this);
        engine.counter += 1;
        engine.run();
    }
}