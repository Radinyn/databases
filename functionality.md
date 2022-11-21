# Podstawy baz danych
Hubert Kowal, Mateusz Knap, Igor Urbanik

# Funkcjonalność

## Role

---

### Pracownik
- Rejestrowanie nowych klientów
- Aktualizowanie menu
    - Dodawanie i usuwanie potraw
    - Modyfikacja cen
    - Oznaczanie stanu dostępności potrawy
    - Sprawdzenie czy menu jest aktualizowane dostatecznie często
- Generowanie listy wolnych stolików
- Potwierdzanie bądź anulowanie złożonych przez klientów zamówień
- Generowanie raportów dla poszczególnych klientów firmowych
- Wystawianie faktur
- Sprawdzanie historii zamówień
- Wyświetlenie zamówień w pewnym okresie (w szczególności aktualnych)

### Właściciel (Administrator)
- Wszystkie uprawnienia pracownika
- Generowanie raportów finansowych restauracji
    - Możliwość sprecyzowania okresu
- Tworzenie, usuwanie, edycja ról
- Pełen dostęp do danych w bazie
- Definiowanie dokładnych zasad działania rabatów

---

### Klient no-name
- Składanie zamówienia online
    - Monitorowanie aktualnego stanu zamówienia
- Składanie zamówienia na miejscu
- Wyświetlanie aktualnego menu
- Możliwość rejestracji online

### Klient indywidualny
- Wszystkie uprwanienia klienta no-name
- Rezerwowanie stolika oraz rezygnacja z rezerwacji
- Sprawdzenie aktualnego postępu rabatów
- Powiadomienia przy zmianie stanu rabatu

### Klient firmowy
- Wszystkie uprwanienia klienta no-name
- Rezerwowanie stolika oraz rezygnacja z rezerwacji
    - Na firmę
    - Imiennie
- Możliwość wybrania rozliczania okresowego (catering)

---

## Funkcje systemowe
- Wyliczanie kosztu zamówienia
- Przydzielanie rabatów
- Sprawdzanie poprawności menu
- Sprawdzanie czy możliwa jest rezerwacja

---

<br>
<details>
<summary>Detale technicznie</summary>

## Restauracja

### Klienci
1. Możliwość zarejestrowania nowego klienta
1. Podział klientów na firmy oraz na indywidualnych
1. Stan rabatów i zamówień dla każdego klienta indywidualnego
1. Dane specyficzne dla firm

### Zamówienia
1. Zamówienia "no-name" i przez zarejestrowanych klientów
1. Zamówienie zawiera potrawę, cenę, datę zamówienia
1. Zamówienia na wynos zawierają także datę odbioru
1. Zamówienia na miejscu zawierają identyfikator stolika
1. Zamówienie jest potwierdzane bądź odrzucane przez pracownika restauracji
1. Firmy mają możliwość złożenia zamówienia cateringowego, składowane są one wtedy specjalnie oznaczone oraz posiadają dodatkowe detale
1. Możliwość zamówienia owoców morza jedynie w czwartek, piątek lub sobotę
1. Zamówienie na owoce morza musi być złożone do poniedziałku poprzedzającego przyjście

### Potrawy
1. Dodawanie nowej potrawy
1. Oznaczanie potrawy za niedostępną
1. Oznaczenie czy dana potrawa jest z kategorii owoców morza

### Menu
1. Każda potrawa może przebywać w menu conajwyżej dwa tygodnie, po czym musi być zmieniona. Stare potrawy mogą wrócić po okresie dwóch tygodni.
1. Możliwość dodawania potraw do menu przy sprawdzeniu powyższego warunku
1. Możliwość usuwania potraw z menu
1. Składowanie historii w celu sprawdzania warunku
1. Informowanie o konieczności zmian w menu oraz przypominanie o przygotowywaniu go z conajmniej jednodniowym wyprzedzniem

### Rezerwacje
1. Rezerwować stolik mogą jedynie zarejestrowani klienci
1. Klienci indywidualni muszą spełniać podstawowe warunki co do wartości zamówienia i ilości wcześniejszych zamówień
1. Stoliki mogą być za
1. Zwrócenie wolnych stolików w danym terminie


### Rabaty
1. Rabaty jedynie dla zarejestrowanych klientów indywidualnych
1. Rabat typu 1 (stałego klienta) - stały niższy procent po przekroczeniu określonej ilości zamówień za określoną kwotę
1. Rabat typu 2 (za kwotę) - wyższy rabat, przyznawany na daną ilość dni po przekroczeniu pewnej kwoty, następnie licznik kwoty wraca do 0
1. Rabaty nie łączą się
1. Rabat typu 2 ma pierwszeństwo
1. Przechowywane są na bazie klientów
1. Trigger na rabaty

### Raporty
1. Wyświetlenie aktualnych zamówień (w pewnym przedziale czasowym)
1. Wyświetlenie aktualnego menu
1. Raporty dla posczególnego klienta
1. Raport finansowy w danym okresie
1. Faktury okresowe dla firm

## Klient

### Zamówienia
1. Klient ma możliwość złożenia zamówienia z wyprzedzeniem

### Rezerwacje
1. Klient indywidualny powinien wiedziec ile mu brakuje by mógł uzyskać stolik
1. Firmy mogą rezerwować stoliki imiennie bądź na firmę
1. Firmy mogą składać zamówienia cateringowe
1. Rezerwacje można anulować
</details>