//
//  NicknameValidate.swift
//  MovieApp
//
//  Created by YoungJin on 8/4/25.
//

import Foundation

enum NicknameValidate: String {
    case valid = "사용할 수 있는 닉네임이에요"
    case length = "2글자 이상 10글자 미만으로 설정해주세요"
    case specialCharacters = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case numbers = "닉네임에 숫자는 포함할 수 없어요"
}
