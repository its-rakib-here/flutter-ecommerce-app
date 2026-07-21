import 'package:flutter/material.dart';

class ProductDescriptionSection extends StatefulWidget {
  final String description;

  const ProductDescriptionSection({super.key, required this.description});

  @override
  State<ProductDescriptionSection> createState() =>
      _ProductDescriptionSectionState();
}

class _ProductDescriptionSectionState extends State<ProductDescriptionSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontSize: size.width * .045,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: size.height * .012),

            Text(
              widget.description,
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size.width * .036,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),

            SizedBox(height: size.height * .012),

            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isExpanded ? "Read Less" : "Read More",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * .035,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.deepOrange,
                    size: size.width * .05,
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * .025),

            const ProductFeaturesSection(),
          ],
        ),
      ),
    );
  }
}

class ProductFeaturesSection extends StatelessWidget {
  const ProductFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size.height * .001),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FeatureItem(
              icon: Icons.local_shipping_outlined,
              iconColor: Colors.brown,
              bgColor: const Color(0xffFFF2E8),
              title: "Free Delivery",
              subtitle: "On orders over \$50",
            ),
          ),

          SizedBox(
            height: size.height * .06,
            child: VerticalDivider(color: Colors.grey.shade300),
          ),

          Expanded(
            child: FeatureItem(
              icon: Icons.history,
              iconColor: Colors.blue,
              bgColor: const Color(0xffEDF5FF),
              title: "7 Days Return",
              subtitle: "Easy returns",
            ),
          ),

          SizedBox(
            height: size.height * .06,
            child: VerticalDivider(color: Colors.grey.shade300),
          ),

          Expanded(
            child: FeatureItem(
              icon: Icons.verified_user_outlined,
              iconColor: Colors.green,
              bgColor: const Color(0xffEDF8EE),
              title: "Secure Payment",
              subtitle: "100% secure",
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String subtitle;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * .10,
          height: size.width * .10,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: size.width * .05),
        ),

        SizedBox(width: size.width * .025),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.width * .033,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: size.height * .004),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.width * .028,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
