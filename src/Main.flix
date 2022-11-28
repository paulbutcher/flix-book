use Api.{parse, Api}
use Api.Api.Api
use HTTP.Request;
use HTTP/Routes.{defaultRoutes, *>, *$>, *$$>};
use HTTP/Server.serve

def handler(req: Request): String = 
    req.uri |> HTTP/Routes.handle(
        ("/" *> index) ::
        defaultRoutes())

def main(): Unit \ IO =
    match parse("api.json") {
        case Err(e) => println(e)
        case Ok(Api(version, namespaces, classes)) => println(version); println(namespaces); println(classes)
    };
    serve(handler)
