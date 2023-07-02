## TCC comandos

### Links
- instalação do Java com <https://sdkman.io/usage> versão 
        sdk install java
        
- versão do Tomcat utilizada: <https://tomcat.apache.org/download-11.cgi>
- ferramenta de testes de carga: <https://github.com/tsenart/vegeta>
- VisualVM: <https://visualvm.github.io/>

### Organização do repositório:
- em [/conf](./conf/) 

        
### Compilar a Servlet
        cd ~/Downloads/11.06.2023/servlet/
        javac -d web/WEB-INF/classes/ -cp /opt/tomcat/lib/\* src/*.java
        jar cvf Servlet.war -C web .
        sudo cp Servlet.war /opt/tomcat/webapps/

### Conseguir abrir o arquivo no /tmp
        cd /tmp/reports
        sudo chmod -R 777 ./

### Manipular o Tomcat
        sudo systemctl start tomcat
        sudo systemctl stop tomcat
        sudo systemctl status tomcat


### Exemplos de URL do Tomcat
        // criar o arquivo .CSV
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true
        

        // testar um número primo sem delay
        curl http://localhost:8080/Servlet/primeNumber?numberToCheck=6696983
        

        // testar um número primo com delay
        curl http://localhost:8080/Servlet/primeNumber?numberToCheck=6696983&delayedExecution=true
        

        // fechar o arquivo .CSV
        curl http://localhost:8080/Servlet/primeNumber?openCSVFile=true
        
