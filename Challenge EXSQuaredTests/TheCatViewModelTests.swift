//
//  TheCatViewModelTests.swift
//  Challenge EXSQuaredTests
//
//  Created by Matias Nicolas Morales on 06/02/2025.
//

import XCTest
@testable import Challenge_EXSQuared

class TheCatViewModelTests: XCTestCase {
    var viewModel: TheCatViewModel!
    var mockService: MockCatService!

    override func setUp() {
        super.setUp()
        mockService = MockCatService()
        viewModel = TheCatViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchCats_Success() {
        // Given
        let mockCats = [
            CatModel(id: "1", url: "https://example.com/cat1.jpg", breeds: []),
        ]
        mockService.result = .success(mockCats)
        let expectation = XCTestExpectation(description: "Fetch Cats Success")
        
        // When
        viewModel.fetchCats()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.cats.count, 1)
            XCTAssertEqual(self.viewModel.cats.first?.id, "1")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    func testFetchCats_Failure() {
        // Given
        mockService.result = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        let expectation = XCTestExpectation(description: "Fetch Cats Failure")
        
        // When
        viewModel.fetchCats()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertTrue(self.viewModel.showingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}

// Mock for simulation red service
class MockCatService: CatService {
    var result: Result<[CatModel], Error>?

    override func fetchCats(from url: String, completion: @escaping (Result<[CatModel], Error>) -> Void) {
        DispatchQueue.main.async {
            if let result = self.result {
                completion(result)
            }
        }
    }
}

