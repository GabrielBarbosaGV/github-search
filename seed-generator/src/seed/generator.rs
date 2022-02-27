use mockall::automock;

#[automock]
pub trait Generator<T> {
    fn generate(&mut self) -> T;
}