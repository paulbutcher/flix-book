namespace Index {

    use Html.Element
    use Html.Element.{Tag, Text}
    use Html.{t, e, +=, +<}

    pub def index(): Nec[Html.Element] =
        e("html") += ("charset", "utf8") +< (
            e("head") +< (
                e("meta") += ("charset", "utf8") ++
                e("meta") += ("name", "viewport") += ("content", "width=device-width, initial-scale=1") ++
                e("title") +< t("Flix API Documentation")
            ) ++
            e("body") +< (
                e("h1") +< t("Hello world!")
            )
        )
}
