import engine, parser, exception;
import std.stdio;

int main(string[] args){
    if(args.length != 2){
        writeln("ファイル名を指定してください");
        return 1;
    }
    string filename = args[1];
    string source = "";
    foreach(line; File(filename, "r").byLine()){
        source ~= line;
    }

    try{
        immutable orders = (new Parser(source)).parse();
        auto engine = new Engine(orders);
        engine.run();
    }catch(SyntaxErrorException err){
        writeln("文法エラー: "~err.message);
        return 1;
    }catch(RuntimeErrorException err){
        writeln("実行時エラー: "~err.message);
        return 1;
    }
    return 0;
}