import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restaurant_app/features/restaurant_detail/cubit/restaurant_detail_cubit.dart';

class RestaurantReviewPage extends StatelessWidget {
  const RestaurantReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantDetailCubit = context.read<RestaurantDetailCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<RestaurantDetailCubit, RestaurantDetailState>(
              builder: (context, state) {
                if (state is RestaurantDetailLoaded) {
                  final reviews = state.restaurant.customerReviews;
                  if (reviews.isEmpty) {
                    return const Center(
                      child: Text('No reviews'),
                    );
                  }
                  return ListView.separated(
                    itemCount: reviews.length,
                    separatorBuilder: (_, __) {
                      return const Divider(
                        height: 0,
                        thickness: 0.5,
                      );
                    },
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ListTile(
                        title: Text(review.name),
                        subtitle: Text(review.review),
                        trailing: Text(
                          review.date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: restaurantDetailCubit,
                          child: const ReviewForm(),
                        );
                      });
                },
                child: const Text('Add Review'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final review = _reviewController.text;
      context.read<RestaurantDetailCubit>().addReview(
            name: name,
            review: review,
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Review',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _reviewController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
