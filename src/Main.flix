use Json.{JsonElement, JsonError, getAtKey}
use Json.JsonError.JsonError
use Json.FromJson
use Json/FromJson.fromJsonAt
use Json/Path.{Path, !!, apply}

instance ToString[JsonError] {
    pub def toString(x: JsonError): String = match x {
        case JsonError(p, ss) => "Error at ${p}:\n${Set.join("\n", ss)}"
    }
}

enum Api(String, List[String], Map[String, List[Class]]) with ToString
enum Class(Sym) with ToString
enum Sym(String) with ToString

instance FromJson[Api] {
    pub def fromJsonAt(p: Path, json: JsonElement): Result[Api, JsonError] = 
        use Result.flatMap;
        let* obj = fromJsonAt(p, json);
        let* version = getAtKey(p, "version", obj);
        let* namespaces = getAtKey(p, "namespaces", obj);
        let* classes = getAtKey(p, "classes", obj);
        Ok(Api(version, namespaces, classes))
}

instance FromJson[Class] {
    pub def fromJsonAt(p: Path, json: JsonElement): Result[Class, JsonError] = 
        use Result.flatMap;
        let* obj = fromJsonAt(p, json);
        let* sym = getAtKey(p, "sym", obj);
        Ok(Class(sym))
}

instance FromJson[Sym] {
    pub def fromJsonAt(p: Path, json: JsonElement): Result[Sym, JsonError] =
        use Result.flatMap;
        let* obj = fromJsonAt(p, json);
        let* name = getAtKey(p, "name", obj);
        Ok(Sym(name))
}

def parse(filename: String): Result[JsonElement, String] \ IO =
    use Result.flatMap;
    let* s = File.read(filename) |> Result.mapErr(s -> "File not found: ${s}");
    Json/Parse.parse(s) |> Option.toOk("Unable to parse api.json")

def main(): Unit \ IO =
    let api: Result[Api, String] = {
        use Result.flatMap;
        let* json = parse("api.json");
        fromJsonAt(Path.Root, json) |> Result.mapErr(ToString.toString)
    };
    match api {
        case Err(e) => println(e)
        case Ok(Api(version, namespaces, classes)) => println(version); println(namespaces); println(classes)
    }
