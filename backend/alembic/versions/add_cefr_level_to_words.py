"""add_cefr_level_to_words

Revision ID: a1b2c3d4e5f6
Revises: f3fbf07ed2b2
Create Date: 2026-01-11 02:00:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '6650655e0ccc'
down_revision: Union[str, None] = 'f3fbf07ed2b2'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Add cefr_level column
    op.add_column('words', sa.Column('cefr_level', sa.String(), nullable=True))


def downgrade() -> None:
    # Remove cefr_level column
    op.drop_column('words', 'cefr_level')
