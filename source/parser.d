import order;
import
    std.array,
    std.conv,
    std.stdio;


class Parser{
    
    private string source;
    this(string source){
        this.source = source;
    }

    public Order[] parse(){
        string queue = "";
        uint[] nestStack;
        Order[] orders = [];

        foreach(char c; this.source){
            if(c == ' ' || c == '\n') continue;
            queue ~= c;
            switch(queue){
                case "しろちゃん!":
                case "しろちゃん！":
                    orders ~= new Right();
                    queue = "";
                    continue;
                case "りんちゃん!":
                case "りんちゃん！":
                    orders ~= new Left();
                    queue = "";
                    continue;
                case "みーちゃん!":
                case "みーちゃん！":
                    orders ~= new Plus();
                    queue = "";
                    continue;
                case "ここちゃん!":
                case "ここちゃん！":
                    orders ~= new Minus();
                    queue = "";
                    continue;
                case "たまちゃん!":
                case "たまちゃん！":
                    orders ~= new PutChar();
                    queue = "";
                    continue;
                case "めいちゃん!":
                case "めいちゃん！":
                    orders ~= new GetChar();
                    queue = "";
                    continue;
                case "みけちゃん!":
                case "みけちゃん！":
                    nestStack ~= orders.length.to!uint; // ネストスタックに命令の番地を積む
                    orders ~= new If0();
                    queue = "";
                    continue;
                case "もかちゃん!":
                case "もかちゃん！":
                    // ネストスタックの一番上の番地のIf0命令に、IfNot0命令の番地を登録する
                    orders[nestStack.back].to!If0.setJumpDest(orders.length.to!uint);

                    // ネストスタックの一番上の番地を、IfNot0命令に登録する
                    IfNot0 order = new IfNot0();
                    order.setJumpDest(nestStack.back);

                    nestStack.popBack(); // ネストスタックの一番上を消す

                    orders ~= order;
                    queue = "";
                    continue;
                default:
                    continue;
            }
        }

        if(queue.length != 0) throw new Exception("構文エラーです");
        if(nestStack.length != 0) throw new Exception("ネストがおかしいです");

        return orders;
    }
}