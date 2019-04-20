import Foundation
import Files

func main() {
    FileVisitor().visit(directoryOrFilePath: "./Tests/textoruTests/", fileExtension: "swift") { (file) in
        TextFounder().run(file: file)
    }
    
    FileVisitor().visit(directoryOrFilePath: "./Tests/textoruTests/", fileExtensions: "xib", "storyboard") { (file) in
        TextVisitorForXIB().visit(file: file)
    }
}

main()
