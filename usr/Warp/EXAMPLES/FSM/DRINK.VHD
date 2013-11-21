library ieee;
use ieee.std_logic_1164.all;

--In keeping with the fact that this is a mythical drink machine, 
--the cost of the drink is 30 cents!

entity drink is port (
	nickel,dime,quarter,clock : in std_logic;
	returnDime,returnNickel,giveDrink: out std_logic); 
end drink;

architecture fsm of drink is
	type drinkState is (zero,five,ten,fifteen,twenty,twentyfive,owedime); 
	signal drinkStatus: drinkState;
begin
	process begin
		wait until clock = '1';
		-- set up default values
		giveDrink <= '0'; 
		returnDime <= '0'; 
		returnNickel <= '0';
		case drinkStatus is
			when zero =>
				IF (nickel = '1') then 
					drinkStatus <= Five; 
				elsif (dime = '1') then
					drinkStatus <= Ten; 
				elsif (quarter = '1') then
					drinkStatus <= TwentyFive; 
				end if;
			when Five =>
				IF (nickel = '1') then
					drinkStatus <= Ten; 
				elsif (dime = '1') then
					drinkStatus <= Fifteen; 
				elsif (quarter = '1') then
					giveDrink <= '1'; 
					drinkStatus <= zero;
				end if; 
			when Ten =>
				IF (nickel = '1') then
					drinkStatus <= Fifteen; 
				elsif (dime = '1') then
					drinkStatus <= Twenty; 
				elsif (quarter = '1') then
					giveDrink <= '1'; 
					returnNickel <= '1'; 
					drinkStatus <= zero;
				end if; 
			when Fifteen =>
				IF (nickel = '1') then
					drinkStatus <= Twenty; 
				elsif (dime = '1') then
					drinkStatus <= TwentyFive; 
				elsif (quarter = '1') then
					giveDrink <= '1'; 
					returnDime <= '1'; 
					drinkStatus <= zero;
				end if; 
			when Twenty =>
				IF (nickel = '1') then
					drinkStatus <= TwentyFive; 
				elsif (dime = '1') then
					giveDrink <= '1'; 
					drinkStatus <= zero;
				elsif (quarter = '1') then
					giveDrink <= '1'; 
					returnNickel <= '1'; 
					returnDime <= '1'; 
					drinkStatus <= zero;
				end if; 
			when TwentyFive =>
				IF (nickel = '1') then
					giveDrink <= '1'; 
					drinkStatus <= zero;
				elsif (dime = '1') then
					returnNickel <= '1'; 
					giveDrink <= '1'; 
					drinkStatus <= zero;
				elsif (quarter = '1') then
					giveDrink <= '1'; 
					returnDime <= '1'; 
					drinkStatus <= oweDime;
				end if;
			when oweDime =>
				returnDime <= '1'; 
				drinkStatus <= zero;
-- The following WHEN makes sure that the state machine resets 
-- itself if it somehow gets into an undefined state.
			when others => 
				drinkStatus <= zero; 
			end case;
		end process;
end fsm;

