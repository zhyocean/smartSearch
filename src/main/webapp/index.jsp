<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        #mydiv{
            position: absolute;
            lift:60%;
            top: 20%;
            margin-left: 300px;
            margin-top: 100px;
        }
        .mouseOver{
            background: #708090;
            color: #FFFAFA;
        }
        .mouseOut{
            background: #FFFAFA;
            color: #000000;
        }
        
    </style>
    <script type="text/javascript">

        var xmlHttp;

        //获得用户输入内容的关联信息的函数
        function getMoreContents() {
            //首先要获得用户的输入
            var result = document.getElementById("keyword");
            if(result == ""){
                clearContent();
                return ;
            }
            //然后给服务器发送输入的内容，因为采用的是ajax异步发送数据，所以要使用一个对象，叫做XmlHttp对象
            xmlHttp = createXMLHttp();
            //要给服务器发送数据
            var url = "search?keyword=" + escape(result.value);
            //true表示javascript脚本会在send()方法之后继续执行，而不会等待来自服务器的相应
            xmlHttp.open("GET",encodeURI(url),true);
            //xmlHttp绑定回调方法，这个回调方法会在xmlHttp状态改变的时候被调用
            //xmlHttp的状态0-4，我们只关心4(complete)这个状态，所以说当完成之后，在调用回调方法才有意义
            xmlHttp.onreadystatechange = callback;
            xmlHttp.send(null);

        }

        //获得XmlHttp对象
        function createXMLHttp() {
            //对于大多数浏览器
            //var xmlHttp；
            if(window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
            //要考虑浏览器的兼容性
            if(window.ActiveXObject) {
                xmlHttp = new XMLHttpRequest("Microsoft.XMLHttp");
                if(!xmlHttp) {
                    xmlHttp = new new XMLHttpRequest("Msxml2.XMLHttp")
                }
            }
            return xmlHttp;
        }

        //回调函数
        function callback() {
            //4代表完成
            if(xmlHttp.readyState == 4) {
                //200代表服务器响应成功
                //404代表资源为找到
                //500代表服务器内部错误
                if (xmlHttp.status == 200){
                    //交互成功，获得相应的数据，是文本格式
                    var result = xmlHttp.responseText;
                    //解析获得数据
                    var json = eval("(" + result + ")");
                    //获得数据之后，就可以动态的显示这些数据了，把这些数据展示到输入框的下面
                    setContent(json);
                }
            }
        }

        //设置关联数据的展示
        function  setContent(contents) {
            clearContent();
            //首先获得关联数据的长度，以此来确定生成多少<tr><td>
            setLocation();
            var size = contents.length;
            //设置内容
            for(var i=0;i<size;i++) {
                var nextNode = contents[i];//代表的是json格式数据的第i个数据
                var tr = document.createElement("tr");
                var td = document.createElement("td");
                td.setAttribute("border","0");
                td.setAttribute("bgcolor","#FFFAFA");
                td.onmouseover = function () {
                    this.className = 'mouseOver';
                };
                td.onmouseout = function () {
                    this.className = 'mouseOut';
                };
                td.onclick = function () {
                  //这个方法实现的是，当用鼠标点击一个关联的数据时，关联数据自动设置为输入框的数据

                };
                var text = document.createTextNode(nextNode);
                td.appendChild(text);
                tr.appendChild(td);
                document.getElementById("content_table_body").appendChild(tr);
            }
        }

        function clearContent() {
            var contentTableBody = document.getElementById("content_table_body");
            var size = contentTableBody.childNodes.length;
            for(var i=size-1;i>=0;i--) {
                //指定要删除的子节点
                contentTableBody.removeChild(contentTableBody.childNodes[i]);
            }
            document.getElementById("popDiv").style.border = "none";
        }

        //当输入框失去焦点的时候，关联信息清空
        function keywordBlur() {
            clearContent();
        }

        //设置关联信息的位置
        function setLocation() {
            //关联信息的显示位置要和输入框一致
            var content = document.getElementById("keyword");
            var width = content.offsetWidth;//输入框的宽度
            var left = content["offsetLeft"];//到左边框的距离
            var top = content["offsetTop"] + content.offsetWidth;//到顶部的距离
            //获得显示数据的div
            var popDiv = document.getElementById("popDiv");
            popDiv.style.border = "black 1px solid";
            popDiv.style.left = left + "px";
            popDiv.style.top = top + "px";
            popDiv.style.width = width + "px";
            document.getElementById("content_table").style.width = width + "px";
        }
    </script>
</head>
<body>

    <div id="mydiv">
        <%--omblur为失去焦点时的处理，onfocus为获得焦点时的处理--%>
        <input type="text" size="50" id="keyword" onkeyup="getMoreContents()" onblur="keywordBlur()" onfocus="getMoreContents()" />
        <input type="button" value="百度一下" width="50px"/>

        <%--下面是内容展示的区域--%>
        <div id="popDiv">
            <table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
                <tbody id="content_table_body">

                    <%--动态查询出来的数据显示在这个地方--%>

                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
