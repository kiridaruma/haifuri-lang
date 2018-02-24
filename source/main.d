import engine;
import std.stdio;

void main(string[] args){
    if(args.length != 2){
        writeln("ファイル名を指定してください");
        return;
    }
    string filename = args[1];
    string source = "";
    foreach(line; File(filename, "r").byLine()){
        source ~= line;
    }

    auto engine = new Engine(source);
    engine.run();
}