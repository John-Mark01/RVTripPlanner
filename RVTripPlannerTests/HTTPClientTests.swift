////
////  HTTPClientTests.swift
////  HTTPClientTests
////
////  Created by John-Mark Iliev on 2.02.26.
////
//
//import XCTest
//
//protocol HTTPClient {
//    func getPoI(from url: URL) async -> PoIDTO
//}
//
//class HTTPClientStub: HTTPClient {
//    
//    func getPoI(from url: URL) async -> PoIDTO {
//        try? await Task.sleep(for: .seconds(2))
//        let poi = TestHelpers.makePOI()
//        return poi
//    }
//}
//
//class NetworkComunicatorStub {
//    let client: HTTPClient
//    let URL: URL
//    
//    init(client: HTTPClient, url: URL) {
//        self.client = client
//        self.URL = url
//    }
//    
//    var recievedMessages: [PoIDTO] = []
//    
//    func getPoI() async {
//        let poi = await client.getPoI(from: URL)
//        recievedMessages.append(poi)
//    }
//}
//
//final class HTTPClientTests: XCTestCase {
//    
//    func test_NetworkComunicator_has_no_recievedMessages_on_init() async {
//        let sut = makeSUT()
//        
//        XCTAssertTrue(sut.recievedMessages.count == 0)
//    }
//    
//    func test_NetworkComunicator_recieves_a_message_when_getPoI_is_called() async {
//        let sut = makeSUT()
//        
//        await sut.getPoI()
//        XCTAssertTrue(sut.recievedMessages.count == 1)
//        
//        await sut.getPoI()
//        XCTAssertTrue(sut.recievedMessages.count == 2)
//        
//    }
//
////MARK: - Helper methods
//    private func makeSUT(
//        with url: URL = URL(string: "https://any-url")!
//    ) -> NetworkComunicatorStub {
//        NetworkComunicatorStub(
//            client: HTTPClientStub(),
//            url: url
//        )
//    }
//}
