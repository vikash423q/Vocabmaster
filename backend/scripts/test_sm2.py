"""
Test SM-2 algorithm with binary correct/incorrect feedback
Run with: python -m scripts.test_sm2
"""
import random
from typing import List, Tuple


# SM-2 Constants for Binary Feedback
INITIAL_EF = 2.5
MIN_EF = 1.3
MAX_EF = 2.5
EF_CORRECT_INCREMENT = 0.15  # Increase EF when correct
EF_INCORRECT_DECREMENT = 0.20  # Decrease EF when incorrect


def adjust_ease_factor(current_ef: float, is_correct: bool) -> float:
    """Adjust ease factor based on binary feedback."""
    if is_correct:
        new_ef = min(MAX_EF, current_ef + EF_CORRECT_INCREMENT)
    else:
        new_ef = max(MIN_EF, current_ef - EF_INCORRECT_DECREMENT)
    return round(new_ef, 2)


def calculate_interval(previous_interval: int, ease_factor: float, is_correct: bool) -> int:
    """Calculate next interval using SM-2 algorithm with binary feedback."""
    if not is_correct:
        # If incorrect, review next day (interval = 1)
        # But we don't reset the progression - just adjust EF
        return 1
    elif previous_interval == 0:
        # First review
        return 1
    elif previous_interval == 1:
        # Second review (after first correct)
        return 2
    else:
        # Subsequent reviews: interval = previous_interval × EF
        new_interval = int(previous_interval * ease_factor)
        return max(1, new_interval)


def simulate_sm2_binary(num_reviews: int = 20, seed: int = None, correct_probability: float = 0.7) -> List[Tuple[int, bool, float, int, str]]:
    """
    Simulate SM-2 algorithm with random binary correct/incorrect feedback.
    
    Args:
        num_reviews: Number of reviews to simulate
        seed: Random seed for reproducibility
        correct_probability: Probability of correct answer (0.0 to 1.0)
    
    Returns: List of (review_num, is_correct, ease_factor, interval, result)
    """
    if seed is not None:
        random.seed(seed)
    
    ease_factor = INITIAL_EF
    interval = 0
    results = []
    
    for review_num in range(1, num_reviews + 1):
        # Random binary choice (True = correct, False = incorrect)
        is_correct = random.random() < correct_probability
        
        # Calculate new interval
        new_interval = calculate_interval(interval, ease_factor, is_correct)
        
        # Adjust ease factor
        ease_factor = adjust_ease_factor(ease_factor, is_correct)
        
        # Determine result description
        result = "✓ Correct" if is_correct else "✗ Incorrect"
        
        results.append((review_num, is_correct, ease_factor, new_interval, result))
        
        interval = new_interval
    return results


def display_experiments(experiments: List[List[Tuple]], num_reviews: int = 20):
    """Display multiple SM-2 experiments side by side."""
    num_experiments = len(experiments)
    
    # Header
    header = "Review |"
    for exp_num in range(1, num_experiments + 1):
        header += f" Exp {exp_num:2d} (C/I/EF/Int) |"
    print("=" * (len(header) + 1))
    print(header)
    print("=" * (len(header) + 1))
    
    # Display each review step
    for review_idx in range(num_reviews):
        row = f"{review_idx + 1:6d} |"
        
        for exp_num in range(num_experiments):
            if review_idx < len(experiments[exp_num]):
                review_num, is_correct, ef, interval, result = experiments[exp_num][review_idx]
                choice_str = "C" if is_correct else "I"
                row += f" {choice_str}/{ef:4.2f}/{interval:3d} {result:10s} |"
            else:
                row += " " * 28 + "|"
        
        print(row)
    
    print("=" * (len(header) + 1))
    
    # Summary for each experiment
    print("\n📊 Summary:")
    print("-" * (len(header) + 1))
    for exp_num in range(num_experiments):
        exp = experiments[exp_num]
        if exp:
            final_ef = exp[-1][2]
            final_interval = exp[-1][3]
            correct_count = sum(1 for r in exp if r[1])  # r[1] is is_correct (bool)
            incorrect_count = len(exp) - correct_count
            
            print(f"Exp {exp_num + 1}: Final EF={final_ef:.2f}, Final Interval={final_interval} days, "
                  f"Correct={correct_count}, Incorrect={incorrect_count}")


def main():
    """Run 5 random SM-2 experiments with binary feedback."""
    print("=" * 80)
    print("🧪 SM-2 Algorithm Test (Binary Feedback) - 5 Random Experiments")
    print("=" * 80)
    print("\nBinary feedback: C = Correct, I = Incorrect")
    print("EF = Ease Factor, Int = Interval (days)")
    print(f"EF adjustment: +{EF_CORRECT_INCREMENT} for correct, -{EF_INCORRECT_DECREMENT} for incorrect")
    print("=" * 80)
    print()
    
    num_reviews = 20
    num_experiments = 5
    correct_probability = 0.7  # 70% chance of correct answer
    
    # Run 5 experiments with different random seeds
    experiments = []
    for exp_num in range(num_experiments):
        seed = random.randint(1, 10000)
        results = simulate_sm2_binary(num_reviews, seed, correct_probability)
        experiments.append(results)
    
    # Display side by side
    display_experiments(experiments, num_reviews)
    
    # Show detailed breakdown for first experiment
    print("\n" + "=" * 80)
    print("📝 Detailed Breakdown - Experiment 1:")
    print("=" * 80)
    print(f"{'Review':<8} {'Result':<12} {'EF':<8} {'Interval':<10} {'Days Since Start':<15}")
    print("-" * 80)
    
    cumulative_days = 0
    for review_num, is_correct, ef, interval, result in experiments[0]:
        cumulative_days += interval
        print(f"{review_num:<8} {result:<12} {ef:<8.2f} {interval:<10} {cumulative_days:<15}")


if __name__ == "__main__":
    main()
