use Html.{doctype, t, e, +=, +<, html}
use Api.Api

def index(api: Api): Unit -> String = () ->
    doctype("html") ++
    e("html") += ("charset", "utf8") +< (
        e("head") +< (
            e("meta") += ("charset", "utf8") ++
            e("meta") += ("name", "viewport") += ("content", "width=device-width, initial-scale=1") ++
            (e("title") +< t("Flix API Documentation")) ++
            e("link") +=
                ("href", "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css") +=
                ("rel", "stylesheet") += 
                ("integrity", "sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65") +=
                ("crossorigin", "anonymous")
        ) ++
        e("body") +< (
            e("h1") +< t("Hello world!") ++
            sidebar(api) ++
            e("script") +=
                ("src", "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js") +=
                ("integrity", "sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4") +=
                ("crossorigin", "anonymous")
        )
    ) |> html
