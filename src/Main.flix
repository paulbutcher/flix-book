use Api.{Api, parse}
use HTTP.Request;
use HTTP/Routes.{defaultRoutes, *>, *$>, *$$>};
use HTTP/Server.serve

def handler(api: Api, req: Request): String =
    req.uri |> HTTP/Routes.handle(
        ("/" *> index(api)) ::
        defaultRoutes())

def runServer(): Result[Unit, String] \ IO =
    use Result.flatMap;
    let* api = parse("api.json");
    Ok(serve(handler(api)))

def main(): Unit \ IO =
    match runServer() {
        case Ok(_) => ()
        case Err(message) => println(message)
    }
