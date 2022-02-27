use super::choice_generator::*;
use crate::empty::Nillable;

impl<T> Nillable for Vec<T> {
    fn is_nil(&self) -> bool {
        self.is_empty()
    }
}

pub type DefaultStringGenerator<T> = ChoiceGenerator<T, Vec<char>>;

pub type DefaultStringGeneratorInit<T> = ChoiceGeneratorInit<T, Vec<char>>;

#[cfg(test)]
mod tests {
    use super::DefaultStringGeneratorInit;

    #[test]
    fn string_generator_holds_values() {
        DefaultStringGeneratorInit {
            into_iterator: 0..50,
            choices: ('a'..='z').collect()
        }.init();
    }
}