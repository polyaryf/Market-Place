// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Text {
  /// Отмена
  internal static let cancel = Text.tr("Localizable", "cancel", fallback: "Отмена")
  /// Изменить
  internal static let change = Text.tr("Localizable", "change", fallback: "Изменить")
  /// Продолжить
  internal static let `continue` = Text.tr("Localizable", "continue", fallback: "Продолжить")
  /// Localizable.strings
  ///   store
  /// 
  ///   Created by Evelina on 30.06.2023.
  internal static let error = Text.tr("Localizable", "error", fallback: "Проверьте соединение с сетью и обновите страницу")
  /// Обновить
  internal static let refresh = Text.tr("Localizable", "refresh", fallback: "Обновить")
  internal enum Admin {
    /// Мои товары
    internal static let myProducts = Text.tr("Localizable", "admin.my_products", fallback: "Мои товары")
    internal enum CreateProduct {
      /// Добавить фото
      internal static let addImage = Text.tr("Localizable", "admin.create_product.add_image", fallback: "Добавить фото")
      /// Создать карточку
      internal static let button = Text.tr("Localizable", "admin.create_product.button", fallback: "Создать карточку")
      /// Выберите категорию товара
      internal static let category = Text.tr("Localizable", "admin.create_product.category", fallback: "Выберите категорию товара")
      /// Карточка товара создана
      internal static let done = Text.tr("Localizable", "admin.create_product.done", fallback: "Карточка товара создана")
      /// Внешний вид
      internal static let view = Text.tr("Localizable", "admin.create_product.view", fallback: "Внешний вид")
      internal enum AddCost {
        /// Введите значение в бонусах
        internal static let placeholder = Text.tr("Localizable", "admin.create_product.add_cost.placeholder", fallback: "Введите значение в бонусах")
        /// Укажите стоимость
        internal static let title = Text.tr("Localizable", "admin.create_product.add_cost.title", fallback: "Укажите стоимость")
      }
      internal enum AddDescription {
        /// Введите описание
        internal static let placeholder = Text.tr("Localizable", "admin.create_product.add_description.placeholder", fallback: "Введите описание")
        /// Добавьте описание
        internal static let title = Text.tr("Localizable", "admin.create_product.add_description.title", fallback: "Добавьте описание")
      }
      internal enum AddName {
        /// Введите название
        internal static let placeholder = Text.tr("Localizable", "admin.create_product.add_name.placeholder", fallback: "Введите название")
        /// Укажите название товара
        internal static let title = Text.tr("Localizable", "admin.create_product.add_name.title", fallback: "Укажите название товара")
      }
      internal enum Preview {
        /// Опубликовать
        internal static let post = Text.tr("Localizable", "admin.create_product.preview.post", fallback: "Опубликовать")
        /// Предпросмотр карточки
        internal static let title = Text.tr("Localizable", "admin.create_product.preview.title", fallback: "Предпросмотр карточки")
      }
    }
    internal enum EditOrder {
      /// Заказ №
      internal static let order = Text.tr("Localizable", "admin.edit_order.order", fallback: "Заказ №")
      /// Сохранить изменения
      internal static let save = Text.tr("Localizable", "admin.edit_order.save", fallback: "Сохранить изменения")
      /// Статус
      internal static let status = Text.tr("Localizable", "admin.edit_order.status", fallback: "Статус")
    }
  }
  internal enum Auth {
    /// Забыли пароль?
    internal static let forgetPassword = Text.tr("Localizable", "auth.forget_password", fallback: "Забыли пароль?")
    /// Войти
    internal static let login = Text.tr("Localizable", "auth.login", fallback: "Войти")
    /// Вход в профиль
    internal static let title = Text.tr("Localizable", "auth.title", fallback: "Вход в профиль")
  }
  internal enum Cart {
    /// Вы точно хотите удалить все товары корзины? Отменить данное действие будет невозможно.
    internal static let deleteAll = Text.tr("Localizable", "cart.delete_all", fallback: "Вы точно хотите удалить все товары корзины? Отменить данное действие будет невозможно.")
    /// Удалить товары
    internal static let deleteAllButton = Text.tr("Localizable", "cart.delete_all_button", fallback: "Удалить товары")
    /// Вы точно хотите удалить выбранный товар? Отменить данное действие будет невозможно.
    internal static let deleteOne = Text.tr("Localizable", "cart.delete_one", fallback: "Вы точно хотите удалить выбранный товар? Отменить данное действие будет невозможно.")
    /// Удалить товар
    internal static let deleteOneButton = Text.tr("Localizable", "cart.delete_one_button", fallback: "Удалить товар")
    /// В корзине пока пусто
    internal static let empty = Text.tr("Localizable", "cart.empty", fallback: "В корзине пока пусто")
    /// Оформить
    internal static let order = Text.tr("Localizable", "cart.order", fallback: "Оформить")
    /// Итоговая стоимость
    internal static let price = Text.tr("Localizable", "cart.price", fallback: "Итоговая стоимость")
    /// Товары
    internal static let products = Text.tr("Localizable", "cart.products", fallback: "Товары")
    /// Корзина
    internal static let title = Text.tr("Localizable", "cart.title", fallback: "Корзина")
    /// Перейти в каталог
    internal static let toCatalog = Text.tr("Localizable", "cart.to_catalog", fallback: "Перейти в каталог")
  }
  internal enum Catalog {
    /// Искать на СкороХод
    internal static let search = Text.tr("Localizable", "catalog.search", fallback: "Искать на СкороХод")
    /// Каталог
    internal static let title = Text.tr("Localizable", "catalog.title", fallback: "Каталог")
    internal enum Categories {
      /// Аксессуары
      internal static let accessories = Text.tr("Localizable", "catalog.categories.accessories", fallback: "Аксессуары")
      /// Зоотовары
      internal static let animals = Text.tr("Localizable", "catalog.categories.animals", fallback: "Зоотовары")
      /// Красота
      internal static let beauty = Text.tr("Localizable", "catalog.categories.beauty", fallback: "Красота")
      /// Детское
      internal static let children = Text.tr("Localizable", "catalog.categories.children", fallback: "Детское")
      /// Одежда
      internal static let clothes = Text.tr("Localizable", "catalog.categories.clothes", fallback: "Одежда")
      /// Электроника
      internal static let electronics = Text.tr("Localizable", "catalog.categories.electronics", fallback: "Электроника")
      /// Дом
      internal static let home = Text.tr("Localizable", "catalog.categories.home", fallback: "Дом")
      /// Спорт
      internal static let sport = Text.tr("Localizable", "catalog.categories.sport", fallback: "Спорт")
    }
  }
  internal enum Filter {
    /// Все категории
    internal static let allCategories = Text.tr("Localizable", "filter.all_categories", fallback: "Все категории")
    /// Применить
    internal static let apply = Text.tr("Localizable", "filter.apply", fallback: "Применить")
    /// Отмена
    internal static let cancel = Text.tr("Localizable", "filter.cancel", fallback: "Отмена")
    /// Цена
    internal static let price = Text.tr("Localizable", "filter.price", fallback: "Цена")
    /// Фильтры
    internal static let title = Text.tr("Localizable", "filter.title", fallback: "Фильтры")
    internal enum Price {
      /// от
      internal static let from = Text.tr("Localizable", "filter.price.from", fallback: "от")
      /// до
      internal static let to = Text.tr("Localizable", "filter.price.to", fallback: "до")
    }
  }
  internal enum Order {
    internal enum Delivery {
      /// Город/Населенный пункт
      internal static let city = Text.tr("Localizable", "order.delivery.city", fallback: "Город/Населенный пункт")
      /// Страна
      internal static let country = Text.tr("Localizable", "order.delivery.country", fallback: "Страна")
      /// Строение/Корпус
      internal static let home = Text.tr("Localizable", "order.delivery.home", fallback: "Строение/Корпус")
      /// Далее
      internal static let next = Text.tr("Localizable", "order.delivery.next", fallback: "Далее")
      /// Улица
      internal static let street = Text.tr("Localizable", "order.delivery.street", fallback: "Улица")
      /// Адрес доставки
      internal static let title = Text.tr("Localizable", "order.delivery.title", fallback: "Адрес доставки")
    }
    internal enum MakingOrder {
      /// Доставка
      internal static let address = Text.tr("Localizable", "order.making_order.address", fallback: "Доставка")
      /// шт.
      internal static let amount = Text.tr("Localizable", "order.making_order.amount", fallback: "шт.")
      /// Ожидаемая дата доставки
      internal static let deliveryDate = Text.tr("Localizable", "order.making_order.delivery_date", fallback: "Ожидаемая дата доставки")
      /// Ваш заказ
      internal static let order = Text.tr("Localizable", "order.making_order.order", fallback: "Ваш заказ")
      /// Оформление заказа
      internal static let title = Text.tr("Localizable", "order.making_order.title", fallback: "Оформление заказа")
      internal enum Payment {
        /// Картой при получении
        internal static let card = Text.tr("Localizable", "order.making_order.payment.card", fallback: "Картой при получении")
        /// Наличными при получении
        internal static let cash = Text.tr("Localizable", "order.making_order.payment.cash", fallback: "Наличными при получении")
        /// Способ оплаты
        internal static let title = Text.tr("Localizable", "order.making_order.payment.title", fallback: "Способ оплаты")
      }
    }
    internal enum OrderDone {
      /// Хорошо
      internal static let next = Text.tr("Localizable", "order.order_done.next", fallback: "Хорошо")
      /// Заказ оформлен
      internal static let title = Text.tr("Localizable", "order.order_done.title", fallback: "Заказ оформлен")
    }
    internal enum Return {
      /// Оформить возврат
      internal static let button = Text.tr("Localizable", "order.return.button", fallback: "Оформить возврат")
      internal enum Confirm {
        /// Нет
        internal static let no = Text.tr("Localizable", "order.return.confirm.no", fallback: "Нет")
        /// Вы уверены, что хотите вернуть посылку?
        internal static let title = Text.tr("Localizable", "order.return.confirm.title", fallback: "Вы уверены, что хотите вернуть посылку?")
        /// Да
        internal static let yes = Text.tr("Localizable", "order.return.confirm.yes", fallback: "Да")
      }
    }
  }
  internal enum OrderHistory {
    /// Дата доставки:
    internal static let orderDateDone = Text.tr("Localizable", "order_history.order_date_done", fallback: "Дата доставки:")
    /// Ожидаемая дата доставки:
    internal static let orderDateExpected = Text.tr("Localizable", "order_history.order_date_expected", fallback: "Ожидаемая дата доставки:")
    /// Заказ от
    internal static let orderFrom = Text.tr("Localizable", "order_history.order_from", fallback: "Заказ от")
    /// Заказы
    internal static let orders = Text.tr("Localizable", "order_history.orders", fallback: "Заказы")
    /// Мои заказы
    internal static let title = Text.tr("Localizable", "order_history.title", fallback: "Мои заказы")
  }
  internal enum Products {
    /// Добавить в корзину
    internal static let addToCart = Text.tr("Localizable", "products.add_to_cart", fallback: "Добавить в корзину")
    /// В корзине
    internal static let addedToCart = Text.tr("Localizable", "products.added_to_cart", fallback: "В корзине")
    /// Описание
    internal static let description = Text.tr("Localizable", "products.description", fallback: "Описание")
  }
  internal enum Profile {
    /// О приложении
    internal static let aboutApp = Text.tr("Localizable", "profile.about_app", fallback: "О приложении")
    /// Мой баланс
    internal static let balance = Text.tr("Localizable", "profile.balance", fallback: "Мой баланс")
    /// Редактировать
    internal static let edit = Text.tr("Localizable", "profile.edit", fallback: "Редактировать")
    /// Профиль
    internal static let tabbarTitle = Text.tr("Localizable", "profile.tabbar_title", fallback: "Профиль")
    /// Мой профиль
    internal static let title = Text.tr("Localizable", "profile.title", fallback: "Мой профиль")
    internal enum ColorTheme {
      /// Темная тема
      internal static let dark = Text.tr("Localizable", "profile.color_theme.dark", fallback: "Темная тема")
      /// Светлая тема
      internal static let light = Text.tr("Localizable", "profile.color_theme.light", fallback: "Светлая тема")
      /// Выбор темы приложения
      internal static let title = Text.tr("Localizable", "profile.color_theme.title", fallback: "Выбор темы приложения")
    }
  }
  internal enum Registration {
    /// Подтверждение пароля
    internal static let confirmationPassword = Text.tr("Localizable", "registration.confirmation_password", fallback: "Подтверждение пароля")
    /// Номер телефона или Email
    internal static let emailPhone = Text.tr("Localizable", "registration.email_phone", fallback: "Номер телефона или Email")
    /// Пароль
    internal static let password = Text.tr("Localizable", "registration.password", fallback: "Пароль")
    /// Зарегистрироваться
    internal static let signup = Text.tr("Localizable", "registration.signup", fallback: "Зарегистрироваться")
    /// Создание аккаунта
    internal static let title = Text.tr("Localizable", "registration.title", fallback: "Создание аккаунта")
  }
  internal enum Review {
    /// Готово
    internal static let done = Text.tr("Localizable", "review.done", fallback: "Готово")
    /// Оцените последний заказ
    internal static let title = Text.tr("Localizable", "review.title", fallback: "Оцените последний заказ")
  }
  internal enum Start {
    /// СкороХод
    internal static let appName = Text.tr("Localizable", "start.app_name", fallback: "СкороХод")
    /// Место быстрых покупок
    internal static let appSlogan = Text.tr("Localizable", "start.app_slogan", fallback: "Место быстрых покупок")
    /// Перейти к каталогу
    internal static let catalogTransition = Text.tr("Localizable", "start.catalog_transition", fallback: "Перейти к каталогу")
    /// Авторизоваться
    internal static let login = Text.tr("Localizable", "start.login", fallback: "Авторизоваться")
    /// Зарегистрироваться
    internal static let signup = Text.tr("Localizable", "start.signup", fallback: "Зарегистрироваться")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Text {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
