<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../../bootstrap-5.0.2-dist/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/homeStyle.css">
        <title>Home</title>
    </head>
    <body>
        <div class="header d-flex align-items-center p-2 d-flex">
            <div class="ms-5 me-2"><img src="assets/images/phone-book.png" alt="phoneBook" width="40">ADDRESS BOOK</div>
            <div class="login"><a href="index.cfm"><img src="assets/images/logout.png" alt="logout" width="20">Logout</a></div>
        </div>
        <div class="homeHeader bg-white d-flex align-items-center justify-content-center">
            <div><img class="pdfImage" src="assets/images/pdf.png" alt="pdfImage" width="30"></div>
            <div><img class="ms-3" src="assets/images/excel.png" alt="excelImage" width="30"></div>
            <div><img class="ms-3" src="assets/images/printer.png" alt="printerImage" width="30"></div>
        </div>
        <div class="d-flex justify-content-center mt-4">
            <div class="userCard bg-white d-flex flex-column align-items-center pt-3 pb-4">
                <div><img class="userImage" src="assets/images/userDefault.jpg" alt="userDefault" width="70"></div>
                <div class="userName mt-4" id="userName"><b>userName</b></div>
                <form>
                    <div class="createContact mt-4"><button>CREATE CONTACT</button></div>
                </form>
            </div>
            <div class="contacts bg-white ms-3">
                <table class="w-100">
                    <tr class="tableHeading">
                        <th></th>
                        <th>NAME</th>
                        <th>EMAIL ID</th>
                        <th>PHONE NUMBER</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>