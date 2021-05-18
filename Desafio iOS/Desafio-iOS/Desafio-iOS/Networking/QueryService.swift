//
//  QueryService.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 03/05/21.
//

import Foundation

enum NetworkError: Error {
    case unexpectedError
    case decodingError
}

class QueryService {
    private let defaultSession = URLSession(configuration: .default)

    private func requestConfiguration(for route: String) -> URLRequest {
        let baseURL = "https://desafio-mobile-bff.herokuapp.com"

//        guard let url = URL(string: baseURL + "/myBalance") else { return }
        let url = URL(string: baseURL + route)
        var request = URLRequest(url: url!) // evitar forçar, fazer o unwrap da url

        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
                         forHTTPHeaderField: "token")
        return request
    }

    func getAmount(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        defaultSession.dataTask(with: requestConfiguration(for: "/myBalance")) { data, response, error in
            if let _ = error {
                completion(.failure(.unexpectedError))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let amountInfo = try decoder.decode(AmountInfo.self, from: data)
                    completion(.success(amountInfo.amount))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }

    func getStatement(completion: @escaping (Result<[StatementInfo], NetworkError>) -> Void) {
        defaultSession.dataTask(with: requestConfiguration(for: "/myStatement/10/0")) { data, response, error
            in
                if let _ = error {
                    completion(.failure(.unexpectedError))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    print("Response HTTP Status code: \(response.statusCode)")

                    do {
                        let decoder = JSONDecoder()
                        print("let decoder ok")
                        let statementInfo = try decoder.decode(Response.self, from: data) // aqui está o erro
                        print("let statementInfo ok")
                        completion(.success(statementInfo.items))
                        print("completion ok")
                    } catch {
                        completion(.failure(.decodingError))
                    }
                }
        }.resume()
    }

}

struct AmountInfo: Codable {
    let amount: Double
}

struct Response: Codable {
    var items: [StatementInfo]
}

struct StatementInfo: Codable {
    let createdAt: String
    let id: String
    let amount: Double
    let description: String
    let tType: String

    // propriedades abaixo dependem do caso
//    let bankName: String
//    let from: String
//    let to: String


    /*
     {
         "items": [
             {
                 "description": "Transferência realizada",
                 "id": "0B5BFD44-0DF1-4005-A7CF-66C9C0438380",
                 "tType": "TRANSFEROUT",
                 "to": "Laura Sacura",
                 "createdAt": "2020-11-29T03:00:00Z",
                 "amount": 1384
             },
             {
                 "description": "Transferência recebida",
                 "id": "4614ED21-9DAD-4A10-8CDC-89A344FF1ADA",
                 "tType": "TRANSFERIN",
                 "to": "Hariel McFly",
                 "amount": 1941,
                 "createdAt": "2020-11-29T03:00:00Z"
             },
             {
                 "description": "Transferência realizada",
                 "tType": "TRANSFEROUT",
                 "id": "1FD425DA-9748-4F8F-95ED-676DD8D74FE4",
                 "to": "Alana Kenobi",
                 "amount": 1826,
                 "createdAt": "2020-11-28T03:00:00Z"
             },
             {
                 "description": "Transferência PIX recebida",
                 "id": "1DC01780-5AEE-4F2E-ADF7-0E596B1ADB79",
                 "tType": "PIXCASHIN",
                 "to": "Karen Amidala",
                 "createdAt": "2020-11-28T03:00:00Z",
                 "amount": 1849
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "E2EE454D-23D0-4CE6-BC3C-F0D58A700294",
                 "to": "Laura Sacura",
                 "amount": 1104,
                 "createdAt": "2020-11-28T03:00:00Z"
             },
             {
                 "description": "Depósito via boleto",
                 "id": "1EC66356-ADC2-49F8-8246-0014F528CA05",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Bernardo de Titã",
                 "amount": 1548,
                 "createdAt": "2020-11-28T03:00:00Z"
             },
             {
                 "description": "Depósito via boleto",
                 "tType": "BANKSLIPCASHIN",
                 "id": "EC5C75A4-444B-433E-9097-680A22D3FD62",
                 "to": "Michel Skywalker",
                 "createdAt": "2020-11-28T03:00:00Z",
                 "amount": 1021
             },
             {
                 "description": "Transferência realizada",
                 "tType": "TRANSFEROUT",
                 "id": "3CF0C3E8-BED9-4789-B317-A9E3386439B3",
                 "to": "Karen Amidala",
                 "amount": 1561,
                 "createdAt": "2020-11-28T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "A828F079-9B02-4D6B-B686-649015848F0A",
                 "tType": "PIXCASHOUT",
                 "to": "Michel Skywalker",
                 "amount": 1402,
                 "createdAt": "2020-11-28T03:00:00Z"
             },
             {
                 "description": "Transferência realizada",
                 "id": "D24747D4-45A1-4FC1-BAA8-FAEB8CA8755B",
                 "tType": "TRANSFEROUT",
                 "to": "Michel Skywalker",
                 "amount": 1650,
                 "createdAt": "2020-11-26T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "description": "Transferência PIX recebida",
                 "from": "Roger Windu",
                 "amount": 1674,
                 "id": "BAF91302-3E25-4E5E-89A6-0F6CD4BEC5B6",
                 "tType": "PIXCASHIN",
                 "createdAt": "2020-11-26T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "0B40BEE9-15AB-4004-9ACA-AF5870DDB93E",
                 "to": "Bernardo de Titã",
                 "amount": 1749,
                 "createdAt": "2020-11-26T03:00:00Z"
             },
             {
                 "description": "Transferência PIX recebida",
                 "tType": "PIXCASHIN",
                 "id": "E6CDED8F-34A0-47F9-9413-C0A381402B6E",
                 "to": "David Bond",
                 "amount": 1611,
                 "createdAt": "2020-11-24T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "03EE0912-3E8E-4493-A934-19A5C1141DC3",
                 "tType": "PIXCASHOUT",
                 "to": "Arthur Hunt",
                 "amount": 1755,
                 "createdAt": "2020-11-24T03:00:00Z"
             },
             {
                 "description": "Transferência realizada",
                 "tType": "TRANSFEROUT",
                 "id": "0DFBB449-53EA-4647-9E81-AD3BE3CA63F9",
                 "to": "Yris Oconnor",
                 "createdAt": "2020-11-23T03:00:00Z",
                 "amount": 1854
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-23T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Yris Oconnor",
                 "id": "FC94FAE6-1C7C-4176-A62B-AAB3B2BC1D30",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1228
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-22T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Bernardo de Titã",
                 "id": "86DFC18A-2606-407C-86D6-D5DDC314247C",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1404
             },
             {
                 "description": "Depósito via boleto",
                 "id": "0DD69EB6-191A-441B-9EF7-FF4C94E3F0C9",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Laura Sacura",
                 "createdAt": "2020-11-21T03:00:00Z",
                 "amount": 1765
             },
             {
                 "description": "Transferência realizada",
                 "id": "2439DCA2-49C0-4025-977D-01E984AFCE7C",
                 "tType": "TRANSFEROUT",
                 "to": "Yris Oconnor",
                 "amount": 1554,
                 "createdAt": "2020-11-21T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-21T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Yris Oconnor",
                 "id": "EF84EBCE-642A-4008-A9DB-51A40D1C3618",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1352
             },
             {
                 "description": "Transferência PIX recebida",
                 "tType": "PIXCASHIN",
                 "id": "49E27207-F3A7-4264-B021-0188690F7D43",
                 "to": "Karen Amidala",
                 "createdAt": "2020-11-19T03:00:00Z",
                 "amount": 1615
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-19T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "David Bond",
                 "id": "8CF70F97-3581-4766-A98C-33A98F390FAA",
                 "tType": "TRANSFERIN",
                 "amount": 1314
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "92FBFAE2-DC75-4EB1-AFA3-2B1E80905075",
                 "to": "Michel Skywalker",
                 "createdAt": "2020-11-19T03:00:00Z",
                 "amount": 1513
             },
             {
                 "description": "Transferência PIX recebida",
                 "id": "9D75B992-BC89-42D1-8A0D-2C3F7ADAB063",
                 "tType": "PIXCASHIN",
                 "to": "Roger Windu",
                 "createdAt": "2020-11-18T03:00:00Z",
                 "amount": 1476
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "3C1DD874-3B6E-496C-85A5-F38352189A8B",
                 "tType": "PIXCASHOUT",
                 "to": "Laura Sacura",
                 "amount": 1477,
                 "createdAt": "2020-11-18T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-18T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "Karen Amidala",
                 "id": "7499C140-7961-43AF-A480-489C9419EEDC",
                 "tType": "TRANSFERIN",
                 "amount": 1750
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "BA1DDE33-7582-4612-B7D6-94AFE9299B31",
                 "to": "Roger Windu",
                 "amount": 1838,
                 "createdAt": "2020-11-17T03:00:00Z"
             },
             {
                 "description": "Transferência PIX recebida",
                 "id": "2722A4E7-5B24-4861-9E5D-00C99BC1E087",
                 "tType": "PIXCASHIN",
                 "to": "Hariel McFly",
                 "amount": 1987,
                 "createdAt": "2020-11-17T03:00:00Z"
             },
             {
                 "description": "Transferência PIX recebida",
                 "id": "B666B964-C299-4F28-865E-8B2666B4D7EC",
                 "tType": "PIXCASHIN",
                 "to": "Roger Windu",
                 "amount": 1214,
                 "createdAt": "2020-11-17T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "81FFE2BD-3A22-45B3-B5F2-A9496FB7E44E",
                 "to": "Karen Amidala",
                 "createdAt": "2020-11-17T03:00:00Z",
                 "amount": 1377
             },
             {
                 "description": "Transferência realizada",
                 "id": "32365403-504C-4CA9-B49D-1A49F02D33C2",
                 "tType": "TRANSFEROUT",
                 "to": "David Bond",
                 "amount": 1463,
                 "createdAt": "2020-11-16T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-14T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "Bernardo de Titã",
                 "id": "C8F78352-4BEB-4189-AE42-50CC3DC624BB",
                 "tType": "TRANSFERIN",
                 "amount": 1378
             },
             {
                 "description": "Depósito via boleto",
                 "id": "F31E2B85-D6B1-42F5-8804-58450E3286B2",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Karen Amidala",
                 "amount": 1910,
                 "createdAt": "2020-11-14T03:00:00Z"
             },
             {
                 "description": "Depósito via boleto",
                 "tType": "BANKSLIPCASHIN",
                 "id": "1B4191EB-85E4-4B8D-A791-26BB5B930A36",
                 "to": "Roger Windu",
                 "createdAt": "2020-11-14T03:00:00Z",
                 "amount": 1022
             },
             {
                 "description": "Depósito via boleto",
                 "id": "2D3BC55D-2F49-48EA-8C25-3C7B1352F253",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Bernardo de Titã",
                 "amount": 1885,
                 "createdAt": "2020-11-14T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "567AC970-77CA-4D49-A4C9-EEC6D5CC4A6E",
                 "tType": "PIXCASHOUT",
                 "to": "David Bond",
                 "amount": 1561,
                 "createdAt": "2020-11-13T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-13T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "Michel Skywalker",
                 "id": "07CF0B38-0C13-44DF-A457-CCC1CF87AE8F",
                 "tType": "TRANSFERIN",
                 "amount": 1604
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "E8A62758-78B1-4CDA-B3D0-ADC99DE17FCC",
                 "to": "Roger Windu",
                 "amount": 1699,
                 "createdAt": "2020-11-12T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "B6266470-CF93-4902-B736-72CFA4D48DBB",
                 "tType": "PIXCASHOUT",
                 "to": "Roger Windu",
                 "createdAt": "2020-11-11T03:00:00Z",
                 "amount": 1119
             },
             {
                 "description": "Depósito via boleto",
                 "id": "240D9379-38D4-4365-82A2-81643D41FD0C",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Alana Kenobi",
                 "amount": 1023,
                 "createdAt": "2020-11-11T03:00:00Z"
             },
             {
                 "description": "Transferência realizada",
                 "id": "F9E60328-01BD-436F-9900-7E5DD77B831F",
                 "tType": "TRANSFEROUT",
                 "to": "Yris Oconnor",
                 "createdAt": "2020-11-11T03:00:00Z",
                 "amount": 1500
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-09T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Roger Windu",
                 "id": "B3E1508E-DEF3-4663-BBE6-A6FE15633B3A",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1006
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-09T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "Alana Kenobi",
                 "id": "642E90A4-B936-43DC-93C0-0C526AF5CF69",
                 "tType": "TRANSFERIN",
                 "amount": 1163
             },
             {
                 "description": "Transferência realizada",
                 "id": "DA52997A-0FFB-4476-8F1C-C086183919E3",
                 "tType": "TRANSFEROUT",
                 "to": "Alana Kenobi",
                 "amount": 1137,
                 "createdAt": "2020-11-08T03:00:00Z"
             },
             {
                 "description": "Depósito via boleto",
                 "id": "2FC71924-5F9A-4A4E-B4FD-7E3B642BD105",
                 "tType": "BANKSLIPCASHIN",
                 "to": "Roger Windu",
                 "amount": 1512,
                 "createdAt": "2020-11-08T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-08T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Bernardo de Titã",
                 "id": "29C62633-053F-4A82-B93B-812084B1FE4F",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1340
             },
             {
                 "description": "Transferência recebida",
                 "tType": "TRANSFERIN",
                 "id": "735A1B57-2218-4F03-876C-41EEAACAEC20",
                 "to": "David Bond",
                 "amount": 1623,
                 "createdAt": "2020-11-08T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-07T03:00:00Z",
                 "description": "Transferência PIX recebida",
                 "from": "Yris Oconnor",
                 "id": "7E0EB0E5-1B3B-4C28-8432-B69C0587E6B7",
                 "tType": "PIXCASHIN",
                 "amount": 1941
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-07T03:00:00Z",
                 "description": "Depósito via boleto",
                 "from": "Bernardo de Titã",
                 "id": "1767CD60-9CF0-4C91-BFB4-DAC0750DB855",
                 "tType": "BANKSLIPCASHIN",
                 "amount": 1709
             },
             {
                 "description": "Transferência realizada",
                 "tType": "TRANSFEROUT",
                 "id": "130A77AF-3A31-4836-B383-C747D65C84A0",
                 "to": "Yris Oconnor",
                 "amount": 1315,
                 "createdAt": "2020-11-06T03:00:00Z"
             },
             {
                 "bankName": "Banco Phi",
                 "createdAt": "2020-11-06T03:00:00Z",
                 "description": "Transferência recebida",
                 "from": "Yris Oconnor",
                 "id": "766A393D-DB3E-4742-B5E1-65F210221250",
                 "tType": "TRANSFERIN",
                 "amount": 1066
             },
             {
                 "description": "Transferência realizada",
                 "id": "0532D62A-69F5-4A72-9A35-CF813A93329F",
                 "tType": "TRANSFEROUT",
                 "to": "Alana Kenobi",
                 "createdAt": "2020-11-06T03:00:00Z",
                 "amount": 1240
             },
             {
                 "description": "Transferência PIX realizada",
                 "id": "B89DAE80-D3F9-4C0B-8FE9-F034DC594701",
                 "tType": "PIXCASHOUT",
                 "to": "Bernardo de Titã",
                 "createdAt": "2020-11-06T03:00:00Z",
                 "amount": 1247
             },
             {
                 "description": "Transferência realizada",
                 "tType": "TRANSFEROUT",
                 "id": "54031C1A-4253-4DE7-A460-A94D267E868D",
                 "to": "Laura Sacura",
                 "amount": 1304,
                 "createdAt": "2020-11-04T03:00:00Z"
             },
             {
                 "description": "Transferência PIX realizada",
                 "tType": "PIXCASHOUT",
                 "id": "A2D414B6-CF55-49EB-AB00-542A153839F3",
                 "to": "Karen Amidala",
                 "createdAt": "2020-11-04T03:00:00Z",
                 "amount": 1697
             },
             {
                 "description": "Transferência PIX recebida",
                 "id": "838C650B-5552-4C95-B044-CE491B70D03C",
                 "tType": "PIXCASHIN",
                 "to": "Arthur Hunt",
                 "createdAt": "2020-11-04T03:00:00Z",
                 "amount": 1691
             },
             {
                 "description": "Transferência realizada",
                 "id": "F6B47C44-E05D-47F9-9BB6-09AADFC2A3B1",
                 "tType": "TRANSFEROUT",
                 "to": "Yris Oconnor",
                 "createdAt": "2020-11-03T03:00:00Z",
                 "amount": 1503
             },
             {
                 "description": "Depósito via boleto",
                 "tType": "BANKSLIPCASHIN",
                 "id": "55E8D9B1-690E-4A6D-B84A-737085B0D747",
                 "to": "David Bond",
                 "amount": 1050,
                 "createdAt": "2020-11-03T03:00:00Z"
             },
             {
             },
             {
             }
         ]
     }

     PIXCASHIN

         "description": "Transferência PIX recebida",
         "id": "74BAD500-B332-4FEF-BAAB-11A76FC904BA",
         "tType": "PIXCASHIN",
         "to": "Laura Sacura",
         "amount": 1125,
         "createdAt": "2020-11-02T03:00:00Z"
     
     PIXCASHOUT

     TRANSFERIN
     TRANSFEROUT


         "description": "Transferência realizada",
         "id": "1568BA0A-7571-4EFA-A131-293620F474E0",
         "tType": "TRANSFEROUT",
         "to": "Laura Sacura",
         "amount": 1258,
         "createdAt": "2020-11-02T03:00:00Z"
     },
     {
         "description": "Transferência realizada",
         "id": "727D8BAB-9E4E-4046-BE4A-16A87C49B6C5",
         "tType": "TRANSFEROUT",
         "to": "Laura Sacura",
         "createdAt": "2020-11-01T03:00:00Z",
         "amount": 1906

     BANKSLIPCASHIN
     */
}
