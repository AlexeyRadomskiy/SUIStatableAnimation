# 🌀 StatableAnimationModifier  
*A production-ready SwiftUI animation modifier with pause, resume & reset support — works even with repeatForever (iOS 14+).*

## 💡 About
`StatableAnimationModifier` solves one of the most annoying SwiftUI issues — **the inability to pause or resume `.repeatForever` animations**.  

In standard SwiftUI, when you try to pause an infinite animation, it jumps, freezes, or restarts from zero.  
This modifier provides a **stable, declarative, production-ready fix** by tracking the animation’s progress through `animatableData`.

## 🎬 Demo
![Demo](https://github.com/user-attachments/assets/9c869dc0-73a0-4a7c-bf38-8c31501cb40b)

## ✨ Features
- ✅ Works with `.repeatForever` animations  
- ✅ Supports **pause**, **resume**, and **reset**  
- ✅ Compatible with **iOS 14+**  
- ✅ Fully **declarative** (no imperative hacks)  
- ✅ Easy to integrate — one line of code  
- ✅ Works with any numeric property (`rotation`, `opacity`, `scale`, etc.)

## ⚙️ Usage Example
```swift
@State private var currentAngle = 0.0

Circle()
    .rotationEffect(.degrees(currentAngle))
    .statableAnimation(
        startValue: $currentAngle,
        endValue: 360.0,
        state: .spinning
    )
```

## 🔖 License

MIT License © 2025 Alexey - Feel free to use, modify, and share.
