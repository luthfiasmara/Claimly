//
//  CommonContainer.swift
//  Common
//
//  Created by Luthfi Asmara on 11/11/25.
//

import Factory

extension Container {
  public var getClaims: Factory<GetClaimsUseCase> {
    Factory(self) { GetClaims(repository: self.claimRepository()) }
  }
}

extension Container {
  public var claimRepository: Factory<ClaimRepository> {
    Factory(self) { DefaultClaimRepository(remoteDataSource: self.commonRemoteDataSource()) }
  }
}

extension Container {
  public var commonRemoteDataSource: Factory<CommonRemoteDataSource> {
    Factory(self) { DefaultCommonRemoteDataSource() }
  }
}
