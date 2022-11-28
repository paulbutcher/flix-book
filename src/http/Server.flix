namespace HTTP/Server {
    import jakarta.servlet.ServletRequest;
    import jakarta.servlet.ServletResponse;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import java.io.PrintWriter;
    import org.eclipse.jetty.server.handler.AbstractHandler;
    import org.eclipse.jetty.server.Handler;
    import org.eclipse.jetty.server.Request;
    import org.eclipse.jetty.server.Server;
    import org.eclipse.jetty.server.handler.HandlerWrapper;
    import org.eclipse.jetty.util.component.AbstractLifeCycle;

    pub def serve(handle: HTTP.Request -> String): Unit \ IO =
        import jakarta.servlet.ServletResponse.getWriter(): PrintWriter \ IO;
        import jakarta.servlet.ServletResponse.setContentType(String): Unit \ IO;
        import jakarta.servlet.http.HttpServletResponse.setStatus(Int32): Unit \ IO;
        import java.io.PrintWriter.print(String): Unit \ IO;
        import org.eclipse.jetty.server.Request.setHandled(Bool): Unit \ IO;
        import new org.eclipse.jetty.server.Server(Int32): Server \ IO as newServer;
        import org.eclipse.jetty.server.Server.join(): Unit \ IO;
        import org.eclipse.jetty.server.handler.HandlerWrapper.setHandler(Handler): Unit \ IO;
        import org.eclipse.jetty.util.component.AbstractLifeCycle.start(): Unit \ IO;

        let server = newServer(8080);
        let handler = new AbstractHandler {
            def handle(_this: AbstractHandler, 
                    _target: String, 
                    jettyRequest: Request, 
                    request: HttpServletRequest, 
                    response: HttpServletResponse): Unit =
                setHandled(jettyRequest, true);
                setStatus(response, 200);
                setContentType(upcast response, "text/html; charset=UTF-8");
                let writer = getWriter(upcast response);
                print(writer, handle(HTTP.mkRequest(request)))
        };
        setHandler(upcast server, upcast handler);
        start(upcast server);
        join(server)
}