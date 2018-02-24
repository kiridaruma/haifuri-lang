import order;
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
        string[] orderWords = splitByOrder(normalizeSource(source));
        this.orders.length = orderWords.length;
        this.memory.length = 3000;

        foreach(uint idx, string order; orderWords){
            switch(order){
                case "しろちゃん":
                    this.orders[idx] = new Right();
                    break;
                case "りんちゃん":
                    this.orders[idx] = new Left();
                    break;
                case "みーちゃん":
                    this.orders[idx] = new Plus();
                    break;
                case "ここちゃん":
                    this.orders[idx] = new Minus();
                    break;
                case "たまちゃん":
                    this.orders[idx] = new PutChar();
                    break;
                case "めいちゃん":
                    this.orders[idx] = new GetChar();
                    break;
                case "みけちゃん":
                    uint i = idx;
                    for(;orderWords[i] != "もかちゃん" || orderWords.length + 1 == i; i += 1){}
                    if(orderWords.length + 1 == i) throw new Exception("syntax error");
                    this.orders[idx] = new If0(i);
                    break;
                case "もかちゃん":
                    uint i = idx;
                    for(;orderWords[i] != "みけちゃん" || uint.max == i; i -= 1){}
                    if(uint.max == i) throw new Exception("syntax error");
                    this.orders[idx] = new IfNot0(i);
                    break;
                default:
                    throw new Exception("syntax error");
            }
        }
    }

    public void run(Engine engine = Engine.init){
        if(Engine.init is engine) engine = this;
        if(engine.counter == engine.orders.length) return;
        engine = orders[counter](this);
        engine.counter += 1;
        engine.run();
    }

    private string normalizeSource(string source){
        return source.replaceAll(regex(`\s|\n`), ""); // 空白と空行を削除
    }

    private string[] splitByOrder(string normalizedSource){
        return normalizedSource.split(regex(`！|!|\n`)).filter!((string s) => s != "").array;
    }
}