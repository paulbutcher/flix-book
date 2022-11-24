def parseApi(): Result[Json.JsonElement, String] \ IO =
    use Result.flatMap;
    let* s = File.read("api.json");
    Json/Parse.parse(s) |> Option.toOk("Unable to parse Json")

// The main entry point.
def main(): Unit \ IO =
    match parseApi() {
        case Err(msg) => println("Error: ${msg}")
        case j => debug(j); ()
    }
