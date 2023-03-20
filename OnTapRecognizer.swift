typealias OnTapClosure = (UITapGestureRecognizer) -> Void

final class OnTapGestureRecognizer: UITapGestureRecognizer {
    private var closure: OnTapClosure
    var event: UIEvent?
    var touches: Set<UITouch>?
    
    init(closure: @escaping OnTapClosure) {
        self.closure = closure
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        closure(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.touches = touches
        self.event = event
    }
}

extension UIView {
    func onTapped(_ closure: @escaping OnTapClosure) {
        let tapHandler = OnTapGestureRecognizer{
            closure($0)
        }
        self.addGestureRecognizer(tapHandler)
    }
    
    func onTapped(_ closure: @escaping EmptyClosure) {
        let tapHandler = OnTapGestureRecognizer{ _ in
            closure()
        }
        self.addGestureRecognizer(tapHandler)
    }
}

//Mark:USAGE
//        button.onTapped { [weak self] in
//            DO_SOMETHING
//        }
