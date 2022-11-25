use Json.{JsonElement, JsonError}
use Json.JsonError.JsonError
use Json/FromJson.fromJsonAt
use Json/Path.{Path, !!, apply}
use Json/Parse.parse

instance ToString[JsonError] {
    pub def toString(x: JsonError): String = match x {
        case JsonError(p, ss) => "Error at ${p}:\n${Set.join("\n", ss)}"
    }
}

def parseApi(): Result[JsonElement, String] \ IO =
    use Result.flatMap;
    let* s = File.read("api.json") |> Result.mapErr(s -> "File not found: ${s}");
    parse(s) |> Option.toOk("Unable to parse api.json")

def getNamespaces(api: JsonElement): Result[List[String], String] =
    use Result.flatMap;
    let p = Path.Root !! "namespaces";
    let* namespaces = api |> apply(p) |> Option.toOk("Unable to find 'namespaces'");
    namespaces |> fromJsonAt(p) |> Result.mapErr(ToString.toString)

def main(): Unit \ IO =
    let namespaces = {
        use Result.flatMap;
        let* api = parseApi();
        api |> getNamespaces
    };
    match namespaces {
        case Err(e) => println(e)
        case j => println(j)
    }
