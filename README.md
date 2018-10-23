_VERSION: 0.1.0_

# T 

Набор утилит и расширений, для упрощения процесса разработки на _swift_ под _ios_. 

### Установка и использование:

Добавить в _Podfile_: 

```ruby
pod 'T', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```
или необходимый модуль: 

Для _Foundation_:

```ruby
pod 'T/Foundation', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```
Для _CoreGraphics_:

```ruby
pod 'T/CoreGraphics', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```
Для _CoreData_:

```ruby
pod 'T/CoreData', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```
Для _UI_:

```ruby
pod 'T/UI', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```

**Использование:**

```swift
import T
```

### Модули: 

- [**Foundation**](#Foundation) - Базовые _'support'_ элементы.
- [**CoreGraphics**](#CoreGraphics) - Для работы с _CoreGraphics_
- [**CoreData**](#CoreData) - Подход к работе с CoreData
- [**UI**](#UI) - Для работы с _UI_

## <a name="Foundation"></a> Foundation

### typealias-ы: 

- _typealias Block = (() -> Void)_
- _typealias BlockFail = ((Error) -> Void)_
- _typealias BlockItem<T> = ((T) -> Void)_
- _typealias BlockFake<T> = ((TimeInterval, T?, Error?) -> Void)_
- _typealias BlocksWorker<T> = (success: BlockItem<T>?, fail: BlockFail?)_

### Глобальные функции: 

Выполнение блока асинхронно, в глобальной очереди

```swift
async({
	// Your code
})
```

Выполнение блока в главной(UI) очереди: 

```swift
main({
	// Your code
})
```

Выполнение блока с указанонй задержкой (в секундах), в указанной очереди (по умолчанию в главной): 

```swift
delay(2, {
	// Your code
})
```

### Расширения для _Data_: 

Инициализация _Data_ из файлов ресорсов: 

```swift
let data = Data(fileName: "json")
```


Json словарь, из даты: 

```swift
let data = Data(fileName: "json")

let json = data?.json // [[AnyHashable: Any]]?
```
    
Строка из даты: 

```swift
let data = Data(fileName: "json")

let str = data?.string // String?
```


## <a name="CoreGraphics"></a> CoreGraphics

#### Установка:

```ruby
pod 'T/CoreGraphics', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```

## <a name="CoreData"></a> CoreData

#### Установка:

```ruby
pod 'T/CoreData', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```

## <a name="UI"></a> UI

#### Установка:

```ruby
pod 'T/UI', :git => 'https://github.com/Virpik/T.git', :branch => 'master'
```


