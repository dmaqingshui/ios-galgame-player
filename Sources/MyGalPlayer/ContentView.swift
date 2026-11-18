import SwiftUI

struct ContentView: View {
    /// 显示用版本号，需与仓库根目录 VERSION 文件、project.yml 的 MARKETING_VERSION 保持一致。
    private let appVersion = "0.1.0"

    var body: some View {
        VStack(spacing: 16) {
            Text("MyGalPlayer")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("版本 \(appVersion)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Divider()
                .padding(.horizontal, 40)

            Text("游戏库（开发中）")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
