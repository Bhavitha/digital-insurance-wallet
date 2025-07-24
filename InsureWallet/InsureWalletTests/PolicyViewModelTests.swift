//
//  PolicyViewModelTests.swift
//  InsureWalletTests
//
//  Created by Bhavitha Gottimukkula on 24/07/25.
//

import XCTest
@testable import InsureWallet


final class PolicyViewModelTests: XCTestCase {
    
    var viewModel: PolicyViewModel!
    var mockService: MockPolicyService!
    
    @MainActor
     override func setUp() {
        super.setUp()
        mockService = MockPolicyService()
        PolicyService.shared = mockService   // Inject mock
        viewModel = PolicyViewModel()
    }
    
    @MainActor
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    @MainActor
    func testInitialState() {
        XCTAssertTrue(viewModel.policies.isEmpty, "Policies should be empty initially")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false initially")
    }
    @MainActor
    func testLoadPoliciesSuccess() async {
        // Given
        mockService.shouldSucceed = true
        mockService.mockPolicies = [
            Policy(id: "1", policyName: "Test Policy", insuranceType: "Life Insurance",
                   provider: "Test Provider", policyNumber: "123", coveredUntil: "2025-12-31",
                   logoUrl: "shield.checkerboard")
        ]
        
        // When
        await viewModel.loadPolicies()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.policies.count, 1)
        XCTAssertEqual(viewModel.policies.first?.policyName, "Test Policy")
    }
    @MainActor
    func testLoadPoliciesFailure() async {
        // Given
        mockService.shouldSucceed = false
        
        // When
        await viewModel.loadPolicies()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.policies.isEmpty, "Policies should remain empty on failure")
    }
}


class MockPolicyService: PolicyService {
    var shouldSucceed = true
    var mockPolicies: [Policy] = []
    
    override func fetchPolicies() async throws -> PolicyResponse {
        if shouldSucceed {
            return PolicyResponse(status: "success", data: mockPolicies)
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
