<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Código que se ejecuta al iniciarse la aplicación

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Código que se ejecuta al cerrarse la aplicación

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Código que se ejecuta cuando se produce un error sin procesar

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Código que se ejecuta al iniciarse una nueva sesión

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Código que se ejecuta cuando finaliza una sesión. 
        // Nota: el evento Session_End se produce solamente con el modo sessionstate
        // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer
        // o SQLServer, el evento no se produce.

    }

    protected void Application_BeginRequest(Object sender, EventArgs e)
    {
        System.Globalization.CultureInfo newCulture = (System.Globalization.CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
        newCulture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        newCulture.DateTimeFormat.DateSeparator = "/";
        newCulture.NumberFormat.CurrencyDecimalSeparator = ".";
        newCulture.NumberFormat.CurrencyDecimalDigits = 3;        
        System.Threading.Thread.CurrentThread.CurrentCulture = newCulture;
    }
       
</script>
