use Api.{parse, Api}
use Api.Api.Api
use Html.html

def main(): Unit \ IO =
    match parse("api.json") {
        case Err(e) => println(e)
        case Ok(Api(version, namespaces, classes)) => println(version); println(namespaces); println(classes)
    };
    println(html(Index.index()))
