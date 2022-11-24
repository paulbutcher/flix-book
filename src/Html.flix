namespace Html {
    pub enum Element {
        case Tag(String, Map[String, String], List[Element])
        case Text(String)
    }

    pub def fmtElement(e: Element): String = match e {
        case Tag(name, attrs, Nil) =>
            "<${name} ${fmtAttrs(attrs)} />"
        case Tag(name, attrs, children) =>
            "<${name} ${fmtAttrs(attrs)}> ${children |> List.joinWith(fmtElement, " ")} </${name}>"
        case Text(s) => s
    }

    def fmtAttrs(attrs: Map[String, String]): String =
        attrs |> Map.joinWith(fmtAttr, " ")

    def fmtAttr(k: String, v: String): String = "${k} = \"${v}\""
}
