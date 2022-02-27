use crate::empty::Nillable;
use rand::{rngs::ThreadRng, seq::SliceRandom};
use super::generator::Generator;

pub struct ChoiceGenerator<T, U> where T: IntoIterator, U: Nillable {
    into_iterator: T,
    choices: U,
    rng: ThreadRng
}

impl<T, U> ChoiceGenerator<T, U> where T: IntoIterator, U: Nillable {
    pub fn new(range: T, choices: U) -> ChoiceGenerator<T, U> {
        ChoiceGenerator {
            into_iterator: range,
            choices,
            rng: rand::thread_rng()
        }
    }
}

pub struct ChoiceGeneratorInit<T, U> where T: IntoIterator, U: Nillable {
    pub into_iterator: T,
    pub choices: U
}

impl<T, U> ChoiceGeneratorInit<T, U> where T: IntoIterator, U: Nillable {
    pub fn init(self) -> ChoiceGenerator<T, U> {
        if self.choices.is_nil() {
            panic!("Choice generator was given collection with empty values");
        }

        ChoiceGenerator::new(self.into_iterator, self.choices)
    }
}

impl<T, V, C> Generator<C> for ChoiceGenerator<T, Vec<V>>
    where T: IntoIterator + Clone,
          C: FromIterator<V>,
          V: Clone
{
    fn generate(&mut self) -> C {
        self.into_iterator
            .clone()
            .into_iter()
            .map(|_| self.choices.choose(&mut self.rng).unwrap().clone())
            .collect::<C>()
    }
}

#[cfg(test)]
mod tests {
    use super::{ChoiceGeneratorInit, Generator};
    use quickcheck::quickcheck;

    #[test]
    fn choice_generator_exists() {
        ChoiceGeneratorInit {
            into_iterator: 0..50,
            choices: ('a'..='z').collect::<Vec<char>>()
        }.init();
    }

    quickcheck! {
        fn default_string_generator_generates_within_possibilities(cs: Vec<char>, iteration_amount: u8) -> bool {
            if cs.is_empty() {
                true
            } else {
                let choices = cs.clone();

                let mut g = ChoiceGeneratorInit {
                    into_iterator: 0..iteration_amount,
                    choices: cs
                }.init();

                Generator::<Vec<char>>::generate(&mut g).iter().all(|x| choices.contains(x))
            }
        }
    }
}