//
//  KingFisher+UIImageView.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setKFImage(
        from url: URL?,
        placeholder: UIImage? = nil,
    ) {
        guard let url = url else {
            self.image = placeholder // url 오류 시 대체이미지로
            return
        }

        let processor = DownsamplingImageProcessor(size: self.bounds.size) // 다운샘플링 프로세서 생성

        let options: KingfisherOptionsInfo = [
            .processor(processor), // 다운샘플링 적용
            .scaleFactor(UIScreen.main.scale), // Retina 화면 스케일 고려 (메모리 효율 ↑) - 픽셀 밀도, @1x, @2x - 다운샘플링과 별도.
            .transition(.fade(0.3)), // 부드러운 전환 효과 - 이미지 등장 애니메이션효과
            .backgroundDecode,
            .cacheMemoryOnly, // 메모리에만 저장.
//            .cacheOriginalImage // 디스크에 원본 이미지 저장
        ]

        self.kf.indicatorType = .activity // 로딩 인디케이터
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        )
    }
    
    func cancelDownload() {
        self.kf.cancelDownloadTask()
    }
}
