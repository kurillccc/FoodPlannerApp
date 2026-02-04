# FoodPlanner

## Описание

FoodPlanner — приложение для просмотра каталога продуктов, добавления товаров в корзину и оформления заказа. Пользователь видит карточки с названием, ценой и изображением, может добавлять товары с мгновенной визуальной обратной связью (анимация, тактильный отклик и бейдж-счётчик на карточке), управлять корзиной и оформлять заказ.

## Скрины

<div style="display: flex; gap: 10px;">
  <img width="200" alt="Onboring" src="https://github.com/user-attachments/assets/9f62776a-7a21-41ca-9884-4446dd764320" />
  <img width="200" alt="Categories" src="https://github.com/user-attachments/assets/eeec2c28-b8e7-45f0-9eac-f5c30e255908" />
  <img width="200" alt="Products" src="https://github.com/user-attachments/assets/8d5ee996-b8cf-43b6-a264-ba94d86c4832" />
  <img width="200" alt="Cart" src="https://github.com/user-attachments/assets/461924fb-57e2-414d-8fda-a2ecc15cb074" />
</div>

## Стек

• Swift

• UIKit

• Auto Layout (NSLayoutConstraint)

• UITabBarController + UINavigationController

• NotificationCenter

• NumberFormatter (валюта)

• UIImpactFeedbackGenerator (haptics)

## Функциональные требования

• Вкладки: Категории и Корзина (Tab Bar).

• Каталог: карточки товаров с ценой, картинкой и кнопкой «Add».

• Добавление товара: анимация, haptics, бейдж-счётчик на карточке, уведомление об обновлении корзины.

• Корзина: список товаров, удаление свайпом, подсчёт общей суммы, оформление заказа (алерт).

• Обновления: экран корзины реагирует на изменения (через NotificationCenter).
